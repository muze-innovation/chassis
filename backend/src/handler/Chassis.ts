import { resolve } from 'path'
import { readFileSync } from 'fs'
import * as TJS from 'typescript-json-schema'
import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import $RefParser from '@apidevtools/json-schema-ref-parser'
import ChassisHelper from './ChassisHelper'
import ChassisConfig from './ChassisConfig'

export default class Chassis {
  private _generator: TJS.JsonSchemaGenerator
  private _program: TJS.Program

  /**
   * Initial json schema generator
   * @param files File path list(ViewSpec, ResolverSpec)
   */
  constructor(files: string[]) {
    // init json schema generator by spec file
    const settings: TJS.PartialArgs = { required: true }
    const compilerOptions: TJS.CompilerOptions = { strictNullChecks: true }

    const specPathResolves: string[] = [
      ...files?.map(path => resolve(path)) ?? [],
    ]

    this._program = TJS.getProgramFromFiles(
      [
        resolve(__dirname, ChassisConfig.screenSpecPath),
        resolve(__dirname, ChassisConfig.viewSpecPath),
        resolve(__dirname, ChassisConfig.resolverSpecPath),
      ].concat(specPathResolves),
      compilerOptions
    )
    this._generator = TJS.buildGenerator(this._program, settings)!
  }

  /**
   * Generate Json Schema
   * @param symbol Data Type
   * @returns JSONSchema
   */
  public async generateJsonSchemaBySymbol(symbol: string): Promise<JSONSchema> {
    const schema = this._generator.getSchemaForSymbol(symbol) as JSONSchema
    // Json schema resolve reference
    return await $RefParser.dereference(schema)
  }

  public async generateJsonSchemaFile(): Promise<JSONSchema[]> {
    const symbols = this._generator.getMainFileSymbols(this._program)
    const jsonSchemas: JSONSchema[] = []

    for (const symbol of symbols) {
      const schema = this._generator.getSchemaForSymbol(symbol) as JSONSchema
      const jsonSchema = await $RefParser.dereference(schema)
      jsonSchemas.push(jsonSchema)
    }

    return jsonSchemas
  }

  /**
   *
   * @param sourceJson
   * @returns Validation Result
   */
  public async validateSpec(sourcePath: string): Promise<boolean> {
    const json = readFileSync(sourcePath, 'utf8')

    const data = JSON.parse(json)

    // Validate Screen Spec
    await this.validateScreenSpec(data)

    // Validate ViewSpec
    await this.validateViewSpec(data)
    return true
  }

  /**
   *
   * @param json Source json input
   * @returns Validation Result
   * @throws Validation Error
   */
  public async validateScreenSpec(json: any): Promise<boolean> {
    const schema = await this.generateJsonSchemaBySymbol(ChassisConfig.screenSpec)
    return ChassisHelper.validateJsonSchema(schema, json)
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
      const { viewType, payload } = shelf
      // Genarate Json schema by viewType
      const viewSpec = await this.generateJsonSchemaBySymbol(viewType)

      // Clone viewSpec
      const viewSpecNoPayload = JSON.parse(JSON.stringify(viewSpec))
      // Delete payload field from JsonSchema spec
      delete viewSpecNoPayload.properties?.payload
      // Validate without payload
      ChassisHelper.validateJsonSchema(viewSpecNoPayload, shelf)

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
  private async validateResolverSpec(payload: any, viewSpec: JSONSchema): Promise<boolean> {
    if (payload.type === 'static') {
      const staticPayload = await this.generateJsonSchemaBySymbol(ChassisConfig.viewPayloadStatic)
      // Validate ChassisViewPayloadStatic Schema
      ChassisHelper.validateJsonSchema(staticPayload, payload)

      // Validate type of payload.data by viewSpec
      ChassisHelper.validateJsonSchema(viewSpec, payload?.data)
    } else if (payload.type === 'remote') {
      const remotePayload = await this.generateJsonSchemaBySymbol(ChassisConfig.viewPayloadRemote)
      // Validate ChassisViewPayloadRemote Schema
      ChassisHelper.validateJsonSchema(remotePayload, payload)

      // Validate ResolverSpec
      // Validate type of payload.output remote by resolver spec
      // Genarate JsonSchema by resolvedWith
      const resolverSpec = await this.generateJsonSchemaBySymbol(payload?.resolvedWith ?? '')

      if (!resolverSpec.properties) {
        throw new Error(`Invalid ResolverSpec: ${payload?.resolvedWith}`)
      }

      const { input, output } = resolverSpec.properties
      // Validate Input
      if (input) {
        ChassisHelper.validateJsonSchema(input as JSONSchema, payload.input)
      }
      // Validate Output
      ChassisHelper.validateSchemaDiff(viewSpec, output as JSONSchema)
    } else {
      throw new Error(`Unknown payload type: ${payload.type}`)
    }

    return true
  }
}
