import { resolve } from "path";
import { readFileSync, readdirSync } from "fs";
import * as TJS from "typescript-json-schema";
import Ajv from "ajv";
import { BaseShelf } from "./spec/BaseShelf";
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
// // map all spec file in spec folder
// const fileSpecs = readdirSync("./src/spec");
// const resolverSpecs = fileSpecs.map((file) => {
//   return resolve(`./src/spec/${file}`);
// });
const program = TJS.getProgramFromFiles(
  [resolve("./src/spec/BaseShelf.ts"), resolve("./src/spec/ViewSpec.ts"), resolve("./src/spec/ResolverSpec.ts")],
  compilerOptions
);

// read json file data need to validate
const data = readFileSync(process.cwd() + "/data.json");
const json = JSON.parse(data.toString()) as BaseShelf[];

const generator = TJS.buildGenerator(program, settings)!;

// validate jsonschema by ajv
const validateJsonSchema = (schema: JSONSchema, json: Object) => {
  const validate = ajv.compile(schema);
  const valid = validate(json);
  if (!valid) console.log("validate failed :", JSON.stringify(validate.errors, null, 2));
  return valid;
};

const validateResolverSpec = async (inputSpec: JSONSchema, outputSpec: JSONSchema, dataSpec: JSONSchema, shelfPayload: any) => {
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
    // Json schema resolve reference
    const viewSpec = await $RefParser.dereference(schemaViewSpec);

    // Validate payload
    const payloadSpec = viewSpec.properties?.payload as JSONSchema;
    let isValidStaticPayload = true;
    let isValidRemotePayload = true;

    // validate payload type static by static payload
    if (payload?.type === "static") {
      isValidStaticPayload = validateJsonSchema(payloadSpec, payload?.data);
    }

    // validate payload type remote by resolver
    if (payload?.type === "remote") {
      const schemaResolverSpec = generator.getSchemaForSymbol(payload?.resolvedWith!) as JSONSchema;
      // Json schema resolve reference
      const resolverSpec = await $RefParser.dereference(schemaResolverSpec);
      // validate resolver spec
      const { input, output } = resolverSpec.properties!;
      isValidRemotePayload = await validateResolverSpec(input as JSONSchema, output as JSONSchema, payloadSpec, payload!);
    }

    // validate json view spec
    delete viewSpec.properties?.payload;
    const isValidViewSpec = validateJsonSchema(viewSpec, shelf);

    if (isValidViewSpec && isValidRemotePayload && isValidStaticPayload) console.log("<----------------------PASS---------------------->");
    else console.log("<---------------------FAILED--------------------->");
  }
}

validateJsonSpec();
