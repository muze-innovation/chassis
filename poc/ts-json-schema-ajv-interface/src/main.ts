import { resolve } from "path";
import { readFileSync, readdirSync } from "fs";
import * as TJS from "typescript-json-schema";
import Ajv from "ajv";
import { BaseShelf } from "./spec/BaseShelf";
import { diffSchemas } from "json-schema-diff";
import { JSONSchema } from "@apidevtools/json-schema-ref-parser";

const ajv = new Ajv();

const settings: TJS.PartialArgs = {
  required: true,
};

const compilerOptions: TJS.CompilerOptions = {
  strictNullChecks: true,
};

const fileSpecs = readdirSync("./src/spec");
const resolverSpecs = fileSpecs.map((file) => {
  return resolve(`./src/spec/${file}`);
});

const program = TJS.getProgramFromFiles(resolverSpecs, compilerOptions);

const data = readFileSync(process.cwd() + "/data.json");
const json = JSON.parse(data.toString()) as BaseShelf[];

const generator = TJS.buildGenerator(program, settings)!;

json.forEach(async (shelf) => {
  const jsonSchema = generator.getSchemaForSymbol(shelf.viewType);

  const validate = ajv.compile(jsonSchema);
  const valid = validate(shelf);
  if (!valid) console.log(JSON.stringify(validate.errors, null, 2));

  if (shelf.payload!.type == "remote") {
    const schemaResolver = generator.getSchemaForSymbol(shelf.payload!.resolvedWith!);

    const output = schemaResolver.properties!.output as unknown as Record<string, any>;
    const refOutput = output["$ref"].split("/");
    const schemaResolveOutput = schemaResolver.definitions![refOutput[refOutput.length - 1]] as JSONSchema;
    console.log(schemaResolveOutput);

    const payload = jsonSchema.properties!.payload as unknown as Record<string, any>;
    const refPayload = payload["$ref"].split("/");
    const schemaPayload = jsonSchema.definitions![refPayload[refPayload.length - 1]] as JSONSchema;
    const data = schemaPayload.properties!.data as unknown as Record<string, any>;
    const refData = data["$ref"].split("/");
    const schemaData = jsonSchema.definitions![refData[refData.length - 1]];
    console.log(schemaData);

    const result = await diffSchemas({
      sourceSchema: schemaResolveOutput as any,
      destinationSchema: schemaData as any,
    });
    if (result.additionsFound == false && result.removalsFound == false) {
      console.log("true");
    } else {
      console.log("false");
    }
  }
});
