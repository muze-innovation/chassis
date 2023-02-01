# CLI for Chassis

# Validate

This command line interface (CLI) tool allows you to validate a JSON file against a set of specification files.

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
