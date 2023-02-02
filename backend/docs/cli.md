# CLI for Chassis

# Validate

This command line interface allows you to validate a JSON file against a set of specification files.

## Usage

To use the tool, run the following command in the terminal:

```sh
chassis validate --source [source file] --spec [array of spec files]
```

or

```sh
chassis validate --source [source file] --dir [spec directory]
```

where:

- `--source` (`-i`) is the path to the JSON file you want to validate (example: `./source.json`)
- `--spec` (`-s`) is an array of the specification file paths (example: `'./ViewSpec.ts','./ResolverSpec.ts'`)
- `--dir` (`-d`) is the path of the specification directory path (example: `'./spec'`)

**Note**: The `--source` option is required to run the validation. And Either `--spec` or `--dir` must be provided, not both.

## Example

To validate a JSON file `./source.json` with specification files `./ViewSpec.ts` and .`/ResolverSpec.ts`, run:

```sh
chassis validate --source './source.json' --spec './ViewSpec.ts','./ResolverSpec.ts'
```

To validate a JSON file `./source.json` with specification files in directory `./spec`, run:

```sh
chassis validate --source './source.json' --dir './spec'
```

Please make sure that the files exists in the given path before running the command.

For more information and options, run `chassis validate --help`.

# Get Specification Schema by Symbol

This command line interface allows you to getting the specification schema by specific symbol.

## Usage

To use the tool, run the following command in the terminal:

```sh
chassis get-schema --symbol [symbol] --file [path of spec file]
```

where

- `--symbol` (`-s`) is the string of class spec name that you want to generate schema (example: `Banner`)
- `--file` (`-f`) is the specification file path (example: `'./ViewSpec.ts'`)

**Note**: Both of `--symbol` and `--file` options are required to run the generate schema.

## Example

To retrieve the specification schema for the `Banner` symbol in the `./ViewSpec.ts` file, run the following command:

```sh
chassis get-schema --symbol 'Banner' --file './ViewSpec.ts'
```

For more information and options, run `chassis get-schema --help`.

# Generate Specification Schema File by Symbol

This command line interface allows you to generating the specification schema file by specific symbol.

## Usage

To use the tool, run the following command in the terminal:

```sh
chassis gen-schema --symbol [symbol] --file [path of spec file]
```

or

```sh
chassis gen-schema --symbol [symbol] --file [path of spec file] --output [path of output schema file]
```

where

- `--symbol` (`-s`) is the required string of class spec name that you want to generate schema (example: `Banner`)
- `--file` (`-f`) is the required specification file path (example: `'./ViewSpec.ts'`)
- `--output` (`-o`) is the optional output directory for the generated JSON schema (example: `'./Schema'`)

## Example

To generate a JSON schema for the `Banner` symbol in the `./ViewSpec.ts` file, run the following command:

```sh
chassis gen-schema --symbol 'Banner' --file './ViewSpec.ts'
```

If you want to specify the output directory, you can run the following command:

```sh
chassis gen-schema --symbol 'Banner' --file './ViewSpec.ts' --output './Schema'
```

For more information and options, run `chassis gen-schema --help`.

# Generate Specification All Schema File

This command line interface allows you to generating JSON schemas from specification files.

## Usage

To use this tool, run the following command in the terminal:

```sh
chassis gen-schema-all --file [spec file]
```

or

```sh
chassis gen-schema-all --file [spec file] --output [output directory]
```

where:

- `--file` or (`-f`) is the required specification file path (example: `./ViewSpec.ts`)
- `--output` or (`-o`) is the optional output directory for the generated JSON schema (example: `./Schema`)

## Example

To generate a JSON schema from the specification file `./ViewSpec.ts`, run the following command:

```sh
chassis gen-schema-all --file './ViewSpec.ts'
```

To generate a JSON schema from the specification file `./ViewSpec.ts` and store it in the directory `./Schema`, run the following command:

```sh
chassis gen-schema-all --file './ViewSpec.ts' --output './Schema'
```

For more information and options, run `chassis gen-schema-all --help`.
