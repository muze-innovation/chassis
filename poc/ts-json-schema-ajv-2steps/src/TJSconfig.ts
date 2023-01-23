import path, { resolve } from "path";
import fs from "fs";
import * as TJS from "typescript-json-schema";

// optionally pass argument to schema generator
const settings: TJS.PartialArgs = {
  required: true,
};

// optionally pass ts compiler options
const compilerOptions: TJS.CompilerOptions = {
  strictNullChecks: true,
};

// Arrange all Specs file directory without Hard code.
const directoryPath = path.join(__dirname, "spec");
const allSpecsPath: string[] = fs.readdirSync(directoryPath).map((fileName) => {
  return resolve(`src/spec/${fileName}`);
});
// optionally pass a base path
const program = TJS.getProgramFromFiles(allSpecsPath, compilerOptions);

// ... or a generator that lets us incrementally get more schemas
const generator = TJS.buildGenerator(program, settings)!;

export { generator };
