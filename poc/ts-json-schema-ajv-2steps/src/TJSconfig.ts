import { resolve } from "path";
import * as TJS from "typescript-json-schema";

// optionally pass argument to schema generator
const settings: TJS.PartialArgs = {
  required: true,
};
// optionally pass ts compiler options
const compilerOptions: TJS.CompilerOptions = {
  strictNullChecks: true,
};
// optionally pass a base path
const program = TJS.getProgramFromFiles(
  [
    resolve("./src/spec/BaseShelf.ts"),
    resolve("./src/spec/Banner.ts"),
    resolve("./src/spec/QuickAccess.ts"),
    resolve("./src/spec/ShelfContent.ts"),
  ],
  compilerOptions
);
// ... or a generator that lets us incrementally get more schemas
const generator = TJS.buildGenerator(program, settings)!;

export { generator };
