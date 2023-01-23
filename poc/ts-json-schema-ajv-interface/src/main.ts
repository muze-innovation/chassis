import { resolve } from "path";
import { readFileSync, readdirSync } from "fs";
import * as TJS from "typescript-json-schema";
import Ajv from "ajv";
import { BaseShelf, BaseShelfPayload } from "./spec/BaseShelf";
import { diffSchemas } from "json-schema-diff";
import { JSONSchema } from "@apidevtools/json-schema-ref-parser";
import $RefParser from "@apidevtools/json-schema-ref-parser";

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

const validateJsonSchema = (schema: JSONSchema, json: Object) => {
  // validate jsonschema by ajv
  const validate = ajv.compile(schema);
  const valid = validate(json);
  if (!valid) console.log("validate failed :", JSON.stringify(validate.errors, null, 2));
  return valid;
};

const validateResolverSpec = async (inputSpec: JSONSchema, outputSpec: JSONSchema, dataSpec: JSONSchema, shelfPayload: BaseShelfPayload) => {
  let isValidInputSpec = true;
  if (inputSpec) isValidInputSpec = validateJsonSchema(inputSpec, shelfPayload.input);

  const validateOutputSpec = await diffSchemas({
    sourceSchema: outputSpec as any,
    destinationSchema: dataSpec as any,
  });

  const isValidOutputSpec = !validateOutputSpec.additionsFound && !validateOutputSpec.removalsFound;
  if (!isValidOutputSpec) console.log("validate resolver failed ", validateOutputSpec.addedJsonSchema);

  return isValidInputSpec && isValidOutputSpec;
};

async function validateJsonSpec() {
  for (const shelf of json) {
    const { viewType, id, payload } = shelf;
    console.log("ID :", id);

    const schemaViewSpec = generator.getSchemaForSymbol(viewType) as JSONSchema;
    // validate json view spec
    const isValidViewSpec = validateJsonSchema(schemaViewSpec, shelf);
    let isValidResolverSpec = true;

    // validate payload type remote by resolver
    if (payload?.type === "remote") {
      const schemaResolverSpec = generator.getSchemaForSymbol(payload?.resolvedWith!) as JSONSchema;
      // Json schema resolve reference
      const resolverSpec = await $RefParser.dereference(schemaResolverSpec);
      const viewSpec = await $RefParser.dereference(schemaViewSpec);
      // validate resolver spec
      const { input, output } = resolverSpec.properties!;

      if (viewSpec.properties) {
        const payloadViewSpec = viewSpec.properties.payload as JSONSchema;
        const dataSpec = payloadViewSpec.properties?.data as JSONSchema;
        isValidResolverSpec = await validateResolverSpec(input as JSONSchema, output as JSONSchema, dataSpec, payload!);
      }
    }

    if (isValidViewSpec && isValidResolverSpec) console.log("<----------------------PASS---------------------->");
    else console.log("<---------------------FAILED--------------------->");
  }
}

validateJsonSpec();
