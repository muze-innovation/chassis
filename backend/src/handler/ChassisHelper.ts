import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import Ajv from 'ajv'
import { diffSchemas } from 'json-schema-diff'
import Table from 'cli-table'

export default class ChassisHelper {
  /**
   * Validate Json with Json Schema
   * @param schema JsonSchema
   * @param json Input json
   * @param throwable Throw exception when json is invalid
   * @returns validation result
   */
  public static validateJsonSchema(
    schema: JSONSchema,
    json: Object,
    viewType: string,
    throwable: boolean = true
  ): boolean {
    const ajv = new Ajv()
    const validation = ajv.compile(schema)
    const isValid = validation(json)
    if (!isValid && throwable) {
      const subTable = new Table({
        head: ['InstancePath', 'Keyword', 'Params', 'Message'],
      })

      let message = 'must match a schema'
      let parentPath = ''

      const errorAnyOf = validation.errors?.find(e => e.keyword === 'anyOf')

      if (errorAnyOf) {
        parentPath = errorAnyOf.instancePath
        const errorTable = new Table({
          head: ['InstancePath', 'Keyword', 'Params'],
        })
        errorTable.push([errorAnyOf.instancePath, errorAnyOf.keyword, this.jsonStringify(errorAnyOf.params)])
        message = `${errorAnyOf.message ?? ''}\n${errorTable.toString()}`
      }

      validation.errors?.forEach(e => {
        if (e.keyword != 'anyOf') {
          subTable.push([
            e.instancePath.replace(parentPath, ''),
            e.keyword,
            this.jsonStringify(e.params),
            e.message ?? '',
          ])
        }
      })

      throw new Error(this.generateErrorTable(viewType, message, subTable.toString()))
    }
    return isValid
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
    viewType: string,
    throwable: boolean = true
  ): Promise<boolean> {
    const validation = await diffSchemas({
      sourceSchema: sourceSchema as any,
      destinationSchema: destinationSchema as any,
    })

    const isValid = !validation.additionsFound && !validation.removalsFound

    if (!isValid && throwable) {
      const subTable = new Table({
        head: ['AddedJsonSchema', 'RemovedJsonSchema'],
      })

      subTable.push([this.jsonStringify(validation.addedJsonSchema), this.jsonStringify(validation.removedJsonSchema)])
      throw new Error(this.generateErrorTable(viewType, 'found json schema diff', subTable.toString()))
    }
    return isValid
  }

  public static jsonStringify(json: Object): string {
    return JSON.stringify(json, null, 2)
  }

  public static generateErrorTable(viewType: string, error: string, description: string): string {
    const mainTable = new Table({
      head: ['ViewType', 'Error', 'Description'],
    })
    mainTable.push([viewType, error, description])
    return mainTable.toString()
  }
}
