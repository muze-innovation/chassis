import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import * as fs from 'fs'
import { resolve } from 'path'
import Ajv, { ErrorObject } from 'ajv'
import { diffSchemas } from 'json-schema-diff'
import Table from 'cli-table'
import ChassisConfig from './ChassisConfig'
import Chassis from './Chassis'

export default class ChassisHelper {
  /**
   * Validate Json with Json Schema
   * @param schema JsonSchema
   * @param json Input json
   * @param throwable Throw exception when json is invalid
   * @returns validation result
   */
  public static validateJsonSchema(schema: JSONSchema, json: Object, throwable: boolean = true): boolean {
    const ajv = new Ajv()
    const validation = ajv.compile(schema)
    const isValid = validation(json)
    if (!isValid && throwable) {
      const errorMessage = this.getErrorValidateJson(validation.errors ?? [])
      throw new Error(errorMessage)
    }
    return isValid
  }

  /**
   * Create an error table to display the errors that validation of a JSON schema
   * @param errors list of error objects produced by the AJV validation process
   * @returns error messsage
   */
  private static getErrorValidateJson(errors: ErrorObject[]): string {
    let errorMessage = 'must match a schema'
    const { instancePathCol, keywordCol, paramsCol, messageCol, parentPathCol } = ChassisConfig.columnJsonSchemaError

    // Find errors of type 'anyOf' to group potential validation errors
    const errorGroup = errors.find(e => e.keyword === 'anyOf')
    if (errorGroup) {
      const path = new Table({
        head: [parentPathCol],
      })
      path.push([errorGroup.instancePath])
      errorMessage = `${errorGroup.message ?? ''}\n${path.toString()}`
      errors = errors.filter(e => e.keyword != 'anyOf')
    }

    // Map error list to error table rows.
    const errorTable = new Table({
      head: [instancePathCol, keywordCol, paramsCol, messageCol],
    })
    errors.forEach(e => {
      const instancePath = e.instancePath.replace(errorGroup?.instancePath ?? '', '')
      const keyword = e.keyword
      const params = this.jsonStringify(e.params)
      const message = e.message ?? ''
      errorTable.push([instancePath, keyword, params, message])
    })

    return `${errorMessage}\n${errorTable.toString()}`
  }

  /**
   *
   * @param sourceSchema
   * @param destinationSchema
   * @param throwable Throw exception when json is invalid
   * @returns validation result
   */
  public static async validateSchemaDiff(
    sourceSchema: JSONSchema,
    destinationSchema: JSONSchema,
    throwable: boolean = true
  ): Promise<boolean> {
    const validation = await diffSchemas({
      sourceSchema: sourceSchema as any,
      destinationSchema: destinationSchema as any,
    })

    const isValid = !validation.additionsFound && !validation.removalsFound

    if (!isValid && throwable) {
      // Create a table to display errors
      const { addedCol, removedCol } = ChassisConfig.columnSchemaDiffError
      const errorTable = new Table({
        head: [addedCol, removedCol],
      })

      errorTable.push([
        this.jsonStringify(validation.addedJsonSchema),
        this.jsonStringify(validation.removedJsonSchema),
      ])

      throw new Error(`found json schema diff\n${errorTable.toString()}`)
    }
    return isValid
  }

  public static jsonStringify(json: Object): string {
    // Convert a JSON object to a string
    return JSON.stringify(json, null, 2)
  }

  public static displayErrorTable(errors: [string, string][]): void {
    // Create a table to display errors
    const { viewTypeCol, errorCol } = ChassisConfig.columnMainError
    const table = new Table({
      head: [viewTypeCol, errorCol],
    })

    table.push(...errors)
    console.log(table.toString())
  }

  public static async validateSpec(source: string, spec: string[], dir: string): Promise<void> {
    let specFiles: string[] = []

    // If dir is not empty
    if (dir) {
      specFiles = fs.readdirSync(dir).map(fileName => {
        return `${dir}/${fileName}`
      })
    } else {
      // Split path file
      if (spec) {
        specFiles = spec[0].split(',')
      } else {
        specFiles = []
      }
    }

    // Create new instance
    const chassis = new Chassis(specFiles.map(s => resolve(s)))
    // Validate spec
    const isValid = await chassis.validateSpec(source)
    console.log(isValid)
  }

  public static async generateJsonSchemaBySymbol(file: string, symbol: string): Promise<JSONSchema> {
    // Create new instance
    const chassis = new Chassis([resolve(file)])
    // Generate schema
    const schema = await chassis.generateJsonSchemaBySymbol(symbol)

    return schema
  }

  public static async generateJsonSchemaFile(
    file: string,
    symbol: string,
    output: string,
    isAllSpec: boolean = false
  ): Promise<void> {
    // Generate schema
    let schema: JSONSchema

    // If generate schema file for all spec
    if (isAllSpec) {
      // Create new instance
      const chassis = new Chassis([resolve(file)])
      // Generate all schema
      schema = await chassis.generateJsonSchemaFile()
    } else {
      schema = await ChassisHelper.generateJsonSchemaBySymbol(file, symbol)
    }

    const dir = output
    // If output option is undefined
    if (!dir) {
      fs.writeFileSync(`./src/SchemaByGenerator.json`, JSON.stringify(schema, null, 2))
    } else {
      // If directory not exist
      if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true })
      }
      fs.writeFileSync(`${dir}/SchemaByGenerator.json`, JSON.stringify(schema, null, 2))
    }
  }
}
