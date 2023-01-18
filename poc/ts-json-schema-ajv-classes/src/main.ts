import { resolve } from "path";
import { readFileSync } from "fs";
import * as TJS from "typescript-json-schema";
import Ajv from "ajv";
import { BaseShelf } from "./spec/BaseShelf";

const ajv = new Ajv();

const settings: TJS.PartialArgs = {
  required: true,
};

const compilerOptions: TJS.CompilerOptions = {
  strictNullChecks: true,
};

const program = TJS.getProgramFromFiles(
  [
    resolve("./src/spec/BaseShelf.ts"),
    resolve("./src/spec/Banner.ts"),
    resolve("./src/spec/ShelfContent.ts"),
    resolve("./src/spec/QuickAccess.ts"),
  ],
  compilerOptions
);

const data = readFileSync(process.cwd() + "/data.json");
const json = JSON.parse(data.toString()) as BaseShelf[];

const generator = TJS.buildGenerator(program, settings)!;

json.forEach((shelf) => {
  const jsonSchema = generator.getSchemaForSymbol(shelf.viewType);

  const validate = ajv.compile(jsonSchema);
  const valid = validate(shelf);
  if (!valid) console.log(JSON.stringify(validate.errors, null, 2));
});
