import { resolve } from "path";
import * as TJS from "typescript-json-schema";
import Ajv from 'ajv'
import sourceJson from '../../data/json-output.json'
import { diffSchemas } from "json-schema-diff";
import traverse, { SchemaObject } from "json-schema-traverse";
import { find, findKey } from "lodash"
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
    resolve("./src/spec/BaseView.ts"),
    resolve("./src/spec/ViewSpec.ts"),
    resolve("./src/spec/ResolverSpec.ts")
  ],
  compilerOptions,
);


const generator = TJS.buildGenerator(program, settings)!;
const ajv = new Ajv()

const getJsonParentSchema = async (sourceSchema: any, destinationSchema: any) => {
  return new Promise<SchemaObject>((resolve, reject) => {
    traverse(destinationSchema, {
      cb: async (
        schema: SchemaObject,
        jsonPtr: string,
        rootSchema: SchemaObject,
        parentJsonPtr?: string,
        parentKeyword?: string,
        parentSchema?: SchemaObject,
        keyIndex?: string | number) => {
          if (keyIndex === 'type' && parentSchema?.properties.type.title === 'StaticPayload#') {
            resolve(parentSchema)
          }
    }})
  })
}

const validateViewSpecSchema = () => {
  const schema = generator.getSchemaForSymbol('ViewSpec')
  console.log(`================== ValidateView Spec ==================`)
  sourceJson.items.forEach((item) => {    
    const valid = ajv.validate(schema, item)
    if (!valid) {
      console.log(`${item.id} failed. Errors: `, ajv.errors)
      return false
    } else {
      console.log(`${item.id} succeeded.`)
      return true
    }
  })
}

const validatResolverSpecSchema = () => {
  console.log(`================== Validate ResolverSpec ==================`)

  sourceJson.items
  // Get all remote shelf
  .filter((item) => item.payload.type === 'remote')
  .forEach(async (item) => {    
    const sourceSchema = generator.getSchemaForSymbol(item.payload.resolvedWith ?? '')    
    const destinationSchema = generator.getSchemaForSymbol(item.viewType)  

    let parentSchema = await getJsonParentSchema(sourceSchema, destinationSchema)

    // Check Difference Schema
    const result = await diffSchemas({
      sourceSchema: sourceSchema.properties?.output as any, 
      destinationSchema: parentSchema.properties?.data as any
    })

    // Validate 2 schemas result
    const isValid = result.additionsFound == false && result.removalsFound == false
    if (!isValid) {
      console.log(`${item.id} validate failed. Errors: `, ajv.errors)
    } else {
      console.log(`${item.id} validate succeeded.`)
    }
  })
}

validateViewSpecSchema()
validatResolverSpecSchema()

// generator can be also reused to speed up generating the schema if usecase allows:
// const schemaWithReusedGenerator = TJS.generateSchema(program, "MyType", settings, [], generator);

// console.log(JSON.stringify(generator.getSchemaForSymbol("BaseShelf")))
// console.log(JSON.stringify(generator.getSchemaForSymbol("Banner"), null, 2))

// // Get symbols for different types from generator.
// generator.getSchemaForSymbol("MyType");
// generator.getSchemaForSymbol("AnotherType");