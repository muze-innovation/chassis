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
   * @param throwable Throw exception when json is invalid.
   * @returns validation result
   */
  public static validateJsonSchema(schema: JSONSchema, json: Object, throwable: boolean = false): boolean {
    const ajv = new Ajv()
    const validate = ajv.compile(schema)
    const valid = validate(json)
    if (!valid && throwable) {
      throw new Error(JSON.stringify(validate.errors, null, 2))
    }
    return valid
  }

  public static async validateSchemaDiff(
    sourceSchema: JSONSchema,
    destinationSchema: JSONSchema,
    throwable: boolean = false
  ): Promise<boolean> {
    const validate = await diffSchemas({
      sourceSchema: sourceSchema as any,
      destinationSchema: destinationSchema as any,
    })

    const valid = !validate.additionsFound && !validate.removalsFound
    if (!valid && throwable) {
      throw new Error(JSON.stringify(validate.addedJsonSchema, null, 2))
    }
    return valid
  }
}
