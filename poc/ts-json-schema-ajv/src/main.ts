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
    resolve("./src/spec/BaseShelf.ts"), resolve("./src/spec/Banner.ts")
  ],
  compilerOptions,
);

// We can either get the schema for one file and one type...
const schema = TJS.generateSchema(program, "BaseShelf", settings);

// ... or a generator that lets us incrementally get more schemas

const generator = TJS.buildGenerator(program, settings)!;

// generator can be also reused to speed up generating the schema if usecase allows:
// const schemaWithReusedGenerator = TJS.generateSchema(program, "MyType", settings, [], generator);

// console.log(JSON.stringify(generator.getSchemaForSymbol("BaseShelf")))
console.log(JSON.stringify(generator.getSchemaForSymbol("Banner"), null, 2))

// // Get symbols for different types from generator.
// generator.getSchemaForSymbol("MyType");
// generator.getSchemaForSymbol("AnotherType");