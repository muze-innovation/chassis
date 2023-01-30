# CLI for Chassis

# Validate

This command line interface (CLI) tool allows you to validate a JSON file against a set of view and resolver specifications.

## Usage

To use the tool, run the following command in the terminal:

```sh
npm run cli validate -- --source [source file] --viewSpec [view spec file] --resolverSpec [resolver spec file]
```

**Note**: All of the options `--source`, `--viewSpec`, `--resolverSpec` are required to run the validation.

where:

- `source` is the path to the JSON file you want to validate (example: `./data/source.json`)
- `viewSpec` is the path to the view specification file (example: `./src/ViewSpec.ts`)
- `resolverSpec` is the path to the resolver specification file (example: `./src/ResolverSpec.ts`)

Please make sure that the files exists in the given path before running the command.

## Example

```sh
npm run cli validate -- --source './data/source.json' --viewSpec './src/ViewSpec.ts' --resolverSpec './src/ResolverSpec.ts'
```

This command will validate the file `./data/source.json` against the view specification file `./src/ViewSpec.ts` and resolver specification file `./src/ResolverSpec.ts`.

Please make sure that the files exists in the given path before running the command.
