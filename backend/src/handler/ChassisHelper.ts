import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import Ajv from 'ajv'
import { diffSchemas } from 'json-schema-diff'
import Table from 'cli-table'

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
      let message = 'must match a schema'
      let parentPath = ''
      let errors = validation.errors ?? []

      const errorAnyOf = validation.errors?.find(e => e.keyword === 'anyOf')

      if (errorAnyOf) {
        parentPath = errorAnyOf.instancePath
        const path = new Table({
          head: ['ParentPath'],
        })
        path.push([errorAnyOf.instancePath])
        message = `${errorAnyOf.message ?? ''}\n${path.toString()}`
        errors = validation.errors?.filter(e => e.keyword != 'anyOf') ?? []
      }

      const errorTable = new Table({
        head: ['InstancePath', 'Keyword', 'Params', 'Message'],
      })

      errors.forEach(e => {
        errorTable.push([
          e.instancePath.replace(parentPath, ''),
          e.keyword,
          this.jsonStringify(e.params),
          e.message ?? '',
        ])
      })

      throw new Error(`${message}\n${errorTable.toString()}`)
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
    throwable: boolean = true
  ): Promise<boolean> {
    const validation = await diffSchemas({
      sourceSchema: sourceSchema as any,
      destinationSchema: destinationSchema as any,
    })

    const isValid = !validation.additionsFound && !validation.removalsFound

    if (!isValid && throwable) {
      const errorTable = new Table({
        head: ['AddedJsonSchema', 'RemovedJsonSchema'],
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
    return JSON.stringify(json, null, 2)
  }

  public static displayErrorTable(errors: [string, string][]): void {
    if (errors.length) {
      const table = new Table({
        head: ['ViewType', 'Error'],
      })

      table.push(...errors)
      console.log(table.toString())
    }
  }
}
