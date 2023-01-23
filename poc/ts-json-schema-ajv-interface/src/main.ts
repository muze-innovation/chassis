import { resolve } from "path";
import { readFileSync, readdirSync } from "fs";
import * as TJS from "typescript-json-schema";
import Ajv from "ajv";
import { BaseShelf } from "./spec/BaseShelf";
import { diffSchemas } from "json-schema-diff";

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
    const schemaPayload = generator.getSchemaForSymbol(shelf.payload!.resolvedWith!);
    //console.log(schemaPayload);
    // if (shelf.payload?.input != undefined) {
    //   const validateInput = ajv.compile(schemaPayload.definitions!.input);
    //   const validInput = validateInput(shelf.payload!.input);
    //   if (!validInput) console.log(JSON.stringify(validate.errors, null, 2));
    // }

    // console.log(jsonSchema.definitions!["Data"]);
    // console.log(schemaPayload.definitions?.output);

    // const result = await diffSchemas({
    //   sourceSchema: jsonSchema.definitions!["Data"] as any,
    //   destinationSchema: schemaPayload.definitions?.output as any,
    // });
    // if (result.additionsFound == false && result.removalsFound == false) {
    //   console.log("true");
    // } else {
    //   console.log("false");
    // }
  }
});
