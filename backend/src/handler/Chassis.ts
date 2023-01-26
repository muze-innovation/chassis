import { resolve } from 'path'
import * as TJS from 'typescript-json-schema'
import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import $RefParser from '@apidevtools/json-schema-ref-parser'
import { Helper } from './Helper'

export default class ChassisEngine {
  private _generator: TJS.JsonSchemaGenerator

  /**
   * Initial json schema generator
   * @param files File path list(ViewSpec, ResolverSpec)
   */
  constructor(files: string[]) {
    // init json schema generator by spec file
    const settings: TJS.PartialArgs = { required: true }
    const compilerOptions: TJS.CompilerOptions = { strictNullChecks: true }

    const program = TJS.getProgramFromFiles(
      [
        resolve('./src/spec/ChassisScreenSpec.ts'),
        resolve('./src/spec/ChassisViewSpec.ts'),
        resolve('./src/spec/ChassisResolverSpec.ts'),
      ].concat(files),
      compilerOptions
    )
    this._generator = TJS.buildGenerator(program, settings)!
  }

  /**
   * Generate Json Schema
   * @param symbol Data Type
   * @returns JSONSchema
   */
  private async generateJsonSchema(symbol: string): Promise<JSONSchema> {
    const schema = this._generator.getSchemaForSymbol(symbol) as JSONSchema
    // Json schema resolve reference
    return await $RefParser.dereference(schema)
  }

  /**
   *
   * @param json
   * @returns Validation Result
   */
  public async validateSpec(json: any): Promise<boolean> {
    // Validate Screen Spec
    await this.validateScreenSpec(json)

    // Validate ViewSpec
    await this.validateViewSpec(json)
    return true
  }

  /**
   *
   * @param json Source json input
   * @returns Validation Result
   * @throws Validation Error
   */
  public async validateScreenSpec(json: any): Promise<boolean> {
    const schema = await this.generateJsonSchema('ChassisScreenSpec')
    return Helper.validateJsonSchema(schema, json)
  }

  /**
   *
   * @param viewType
   * @param json
   * @throws Validation Error
   * @returns Validation Result
   */
  public async validateViewSpec(json: any): Promise<boolean> {
    for (const shelf of json.items) {
      const { viewType, id, payload } = shelf
      // Genarate Json schema by viewType
      const viewSpec = await this.generateJsonSchema(viewType)
      // Clone viewSpec
      const viewSpecNoPayload = JSON.parse(JSON.stringify(viewSpec))
      // Delete payload field from JsonSchema spec
      delete viewSpecNoPayload.properties?.payload
      // Validate without payload
      Helper.validateJsonSchema(viewSpecNoPayload, shelf)

      const payloadSpec = viewSpec.properties?.payload as JSONSchema

      if (payload) {
        // Validate payload
        await this.validateResolverSpec(payload, payloadSpec)
      }
    }

    return true
  }

  /**
   * 1. Validate with `ChassisViewPayloadStatic` or `ChassisViewPayloadRemote`
   * 2. Validate ResolverSpec (Input, Output)
   * @param Payload
   * @param Spec
   */
  private async validateResolverSpec(payload: any, spec: JSONSchema): Promise<boolean> {
    if (payload.type === 'static') {
      const staticPayload = await this.generateJsonSchema('ChassisViewPayloadStatic')
      // Validate ChassisViewPayloadStatic Schema
      Helper.validateJsonSchema(staticPayload, payload)

      // Validate type of payload.data by viewSpec
      Helper.validateJsonSchema(spec, payload?.data)
    } else if (payload.type === 'remote') {
      const remotePayload = await this.generateJsonSchema('ChassisViewPayloadRemote')
      // Validate ChassisViewPayloadRemote Schema
      Helper.validateJsonSchema(remotePayload, payload)

      // Validate ResolverSpec
      // Validate type of payload.output remote by resolver spec
      // Genarate JsonSchema by resolvedWith
      const resolverSpec = await this.generateJsonSchema(payload?.resolvedWith ?? '')

      if (!resolverSpec.properties) {
        throw new Error(`Invalid ResolverSpec: ${payload?.resolvedWith}`)
      }

      const { input, output } = resolverSpec.properties
      // Validate Input
      if (input) {
        Helper.validateJsonSchema(input as JSONSchema, payload.input)
      }
      // Validate Output
      Helper.validateSchemaDiff(output as JSONSchema, spec)
    } else {
      throw new Error(`Unknown payload type: ${payload.type}`)
    }

    return true
  }
}
