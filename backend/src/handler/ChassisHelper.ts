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
      const errors = validation.errors?.map(e => {
        return {
          viewType: viewType,
          instancePath: e.instancePath,
          keyword: e.keyword,
          params: JSON.stringify(e.params, null, 2).replace(/[\s\n]/g, ''),
          message: e.message,
        }
      })

      const err = JSON.stringify(errors, null, 2)
      throw new Error(err)
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

      const table = new Table({
        head: ['ViewType', 'AddedJsonSchema', 'RemovedJsonSchema'],
      });

      table.push(
        [viewType, JSON.stringify(validation.addedJsonSchema, null, 2), JSON.stringify(validation.removedJsonSchema, null, 2)],
      );

      console.log(table.toString());
      throw new Error()

    }
    return isValid
  }
}
