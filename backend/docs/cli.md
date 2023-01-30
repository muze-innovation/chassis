# CLI for Chassis

# Validate

This command line interface (CLI) tool allows you to validate a JSON file against a set of specification files.

## Usage

To use the tool, run the following command in the terminal:

```sh
chassis validate --source [source file] --spec [array of spec files]
```

where:

- `source` (`-i`) is the path to the JSON file you want to validate (example: `./data/source.json`)
- `spec` (`-s`) is an array of the specification file paths (example: `./src/ViewSpec.ts,./src/ResolverSpec.ts`)

Please make sure that the files exists in the given path before running the command.

**Note**: Both `--source` and `--spec` options are required to run the validation.

## Example

```sh
chassis validate --source './data/source.json' --spec './src/ViewSpec.ts','./src/ResolverSpec.ts'
```

This command will validate the file `./data/source.json` against the specification files `./src/ViewSpec.ts` and `./src/ResolverSpec.ts`.

Please make sure that the files exists in the given path before running the command.
