import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import Ajv from 'ajv'
import { readFileSync } from 'fs'
import { diffSchemas } from 'json-schema-diff'
import { ChassisViewSpec } from '../spec/ChassisViewSpec'

export class Helper {
  /**
   * Read Json Input File
   * @param inputPath
   * @returns
   */
  public static parseJsonToShelf(inputPath: string): ChassisViewSpec[] {
    // Read json file data need to validate
    const data = readFileSync(process.cwd() + inputPath)
    return JSON.parse(data.toString()) as ChassisViewSpec[]
  }

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
      const err = JSON.stringify(validation.errors, null, 2)
      console.error(err)
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
    throwable: boolean = true
  ): Promise<boolean> {
    const validation = await diffSchemas({
      sourceSchema: sourceSchema as any,
      destinationSchema: destinationSchema as any,
    })

    const isValid = !validation.additionsFound && !validation.removalsFound
    if (!isValid && throwable) {
      const err = JSON.stringify(validation.addedJsonSchema, null, 2)
      console.error(err)
      throw new Error(err)
    }
    return isValid
  }
}
