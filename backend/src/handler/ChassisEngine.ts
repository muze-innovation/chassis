import { resolve } from "path";
import * as TJS from "typescript-json-schema";
import Ajv from "ajv";
import { diffSchemas } from "json-schema-diff";
import { JSONSchema } from "@apidevtools/json-schema-ref-parser";
import $RefParser from "@apidevtools/json-schema-ref-parser";
import { Helper } from "./Helper";

export default class ChassisEngine {
  private static _generator: TJS.JsonSchemaGenerator;

  private static validateJsonSchema(schema: JSONSchema, json: Object): void {
    const ajv = new Ajv();
    const validate = ajv.compile(schema);
    const valid = validate(json);
    if (!valid) {
      throw new Error(JSON.stringify(validate.errors, null, 2));
    }
  }

  private static async validateSchemaDiff(sourceSchema: JSONSchema, destinationSchema: JSONSchema): Promise<void> {
    const validate = await diffSchemas({
      sourceSchema: sourceSchema as any,
      destinationSchema: destinationSchema as any,
    });

    const valid = !validate.additionsFound && !validate.removalsFound;
    if (!valid) {
      throw new Error(JSON.stringify(validate.addedJsonSchema, null, 2));
    }
  }

  private static initJsonSchemaGenerator(): void {
    // init json schema generator by spec file
    const settings: TJS.PartialArgs = { required: true };
    const compilerOptions: TJS.CompilerOptions = { strictNullChecks: true };

    const program = TJS.getProgramFromFiles(
      [resolve("./src/spec/BaseShelf.ts"), resolve("./src/spec/ViewSpec.ts"), resolve("./src/spec/ResolverSpec.ts")],
      compilerOptions
    );
    this._generator = TJS.buildGenerator(program, settings)!;
  }

  private static async generateJsonSchema(symbol: string): Promise<JSONSchema> {
    const schema = this._generator.getSchemaForSymbol(symbol) as JSONSchema;
    // Json schema resolve reference
    return await $RefParser.dereference(schema);
  }

  /**
   * validate json with ts file spec
   */
  public static async validateSpec(inputPath: string) {
    this.initJsonSchemaGenerator();
    // read json file data need to validate
    const shelfList = Helper.parseJsonToShelf(inputPath);

    for (const shelf of shelfList) {
      const { viewType, id, payload } = shelf;
      console.log("ID :", id);
      // genarate Json schema by viewType
      const viewSpec = await this.generateJsonSchema(viewType);
      const payloadSpec = viewSpec.properties?.payload as JSONSchema;

      try {
        // validate json view spec
        delete viewSpec.properties?.payload;
        this.validateJsonSchema(viewSpec, shelf);
        if (payload) {
          // validate payload
          await this.validatePayload(payload, payloadSpec);
        }
        console.log("<----------------------PASS---------------------->");
      } catch (e) {
        const error = e as Error;
        console.log(`Validate failed : ${error.message}\n<---------------------FAILED--------------------->`);
      }
    }
  }

  private static async validatePayload(payload: any, spec: JSONSchema): Promise<void> {
    if (payload.type === "static") {
      const staticPayload = await this.generateJsonSchema("BaseShelfStaticPayload");

      this.validateJsonSchema(staticPayload, payload);

      // validate data static by static payload
      this.validateJsonSchema(spec, payload?.data);
    } else if (payload.type === "remote") {
      const remotePayload = await this.generateJsonSchema("BaseShelfRemotePayload");

      this.validateJsonSchema(remotePayload, payload);

      // validate data output remote by resolver
      // genarate Json schema by resolvedWith

      const resolverSpec = await this.generateJsonSchema(payload?.resolvedWith!);

      // validate resolver spec
      const { input, output } = resolverSpec.properties!;
      if (input) this.validateJsonSchema(input as JSONSchema, payload.input);

      this.validateSchemaDiff(output as JSONSchema, spec);
    } else {
      throw new Error(`Unknown payload type ${payload.type}`);
    }
  }
}
