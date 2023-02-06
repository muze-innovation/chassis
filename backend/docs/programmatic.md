# Programmatic

# Defined instance chassis

```ts
import Chassis from 'chassis'

const chassis = new Chassis([resolve(__dirname, 'path/spec/Spec1.ts'), resolve(__dirname, 'path/spec/Spec2.ts')])
```

# Validate

This function allows you to validate a JSON file against a set of specification files.

## Usage

To use the tool, import function from chassis:

```ts
await chassis.validateSpec(resolve(__dirname, 'path/source.json'))
```

# Generate Specification Schema File by Symbol

This function allows you to generating the specification schema file by specific symbol.

## Usage

To use the tool, import function from chassis:

```ts
await chassis.generateJsonSchemaBySymbol('Banner')
```

# Generate Specification All Schema File

This function allows you to generating JSON schemas from specification files.

## Usage

To use this tool, run the following command in the terminal:

```ts
await chassis.generateJsonSchemaFile()
```