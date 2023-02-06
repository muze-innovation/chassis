import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import Ajv, { ErrorObject } from 'ajv'
import { diffSchemas } from 'json-schema-diff'
import Table from 'cli-table'
import ChassisConfig from './ChassisConfig'

//const table = new Table([''])

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
}
