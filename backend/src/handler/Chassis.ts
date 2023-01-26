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
      [resolve('./src/spec/BaseViewSpec.ts'), resolve('./src/spec/BaseResolverSpec.ts')].concat(files),
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

    for (const shelf of json.shelfList) {
      const { viewType, id, payload } = shelf
      console.log('ID :', id)
      // Genarate Json schema by viewType
      const viewSpec = await this.generateJsonSchema(viewType)
      const payloadSpec = viewSpec.properties?.payload as JSONSchema

      try {
        // Validate json view spec
        delete viewSpec.properties?.payload
        Helper.validateJsonSchema(viewSpec, shelf)
        if (payload) {
          // Validate payload
          await this.validatePayload(payload, payloadSpec)
        }
        console.log('<----------------------PASS---------------------->')
      } catch (e) {
        const error = e as Error
        console.log(`Validate failed : ${error.message}\n<---------------------FAILED--------------------->`)
      }
    }

    const resolverSpec = await this.generateJsonSchema('ViewSpec')
    console.log(JSON.stringify(resolverSpec, null, 2))
    return true
  }

  private async validatePayload(payload: any, spec: JSONSchema): Promise<void> {
    if (payload.type === 'static') {
      const staticPayload = await this.generateJsonSchema('BaseShelfStaticPayload')

      Helper.validateJsonSchema(staticPayload, payload)

      // validate data static by static payload
      Helper.validateJsonSchema(spec, payload?.data)
    } else if (payload.type === 'remote') {
      const remotePayload = await this.generateJsonSchema('BaseShelfRemotePayload')

      Helper.validateJsonSchema(remotePayload, payload)

      // validate data output remote by resolver
      // genarate Json schema by resolvedWith

      const resolverSpec = await this.generateJsonSchema(payload?.resolvedWith!)

      // validate resolver spec
      const { input, output } = resolverSpec.properties!
      if (input) Helper.validateJsonSchema(input as JSONSchema, payload.input)

      Helper.validateSchemaDiff(output as JSONSchema, spec)
    } else {
      throw new Error(`Unknown payload type ${payload.type}`)
    }
  }
}
