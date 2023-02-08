import { promises } from 'fs'
import fs from 'fs'
import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import { resolve } from 'path'
import ChassisHelper from '@/src/handler/ChassisHelper'

jest.setTimeout(10000) // 10 seconds

describe('Helper', () => {
  describe('validateJsonSchema', () => {
    it('valid JSON', () => {
      const schema = {
        type: 'object',
        properties: {
          id: {
            type: 'string',
          },
          viewType: {
            type: 'string',
            enum: ['Banner'],
          },
        },
      } as JSONSchema
      const json = { id: 'recent_orders_shelf_content', viewType: 'Banner' }

      expect(ChassisHelper.validateJsonSchema(schema, json)).toBe(true)
    })

    it('invalid JSON', () => {
      const schema = {
        type: 'object',
        properties: {
          id: {
            type: 'string',
          },
          viewType: {
            type: 'string',
            enum: ['Banner'],
          },
        },
      } as JSONSchema
      const json = { id: 'recent_orders_shelf_content', viewType: 'QuickAccess' }

      expect(ChassisHelper.validateJsonSchema(schema, json, false)).toBe(false)
    })

    it('throws error on invalid JSON', () => {
      const schema = {
        type: 'object',
        properties: {
          id: {
            type: 'string',
          },
          viewType: {
            type: 'string',
            enum: ['Banner'],
          },
        },
      } as JSONSchema
      const json = { id: 'recent_orders_shelf_content', viewType: 'QuickAccess' }

      expect(() => ChassisHelper.validateJsonSchema(schema, json)).toThrow()
    })

    it('not throws error on invalid JSON and throwable is set to false', () => {
      const schema = {
        type: 'object',
        properties: {
          id: {
            type: 'string',
          },
          viewType: {
            type: 'string',
            enum: ['Banner'],
          },
        },
      } as JSONSchema
      const json = { id: 'recent_orders_shelf_content', viewType: 'QuickAccess' }
      const result = ChassisHelper.validateJsonSchema(schema, json, false)

      expect(result).toBe(false)
    })
  })

  describe('validateSchemaDiff', () => {
    it('valid schema diff', async () => {
      const sourceSchema = {
        type: 'object',
        properties: { asset: { type: 'string' }, placeholder: { type: 'string' } },
      } as JSONSchema
      const destinationSchema = {
        type: 'object',
        properties: { asset: { type: 'string' }, placeholder: { type: 'string' } },
      } as JSONSchema

      expect(await ChassisHelper.validateSchemaDiff(sourceSchema, destinationSchema)).toBe(true)
    })

    it('invalid schema diff', async () => {
      const sourceSchema = {
        type: 'object',
        properties: { asset: { type: 'string' }, placeholder: { type: 'string' } },
      } as JSONSchema
      const destinationSchema = {
        type: 'object',
        properties: { asset: { type: 'string' } },
      } as JSONSchema

      expect(await ChassisHelper.validateSchemaDiff(sourceSchema, destinationSchema, false)).toBe(false)
    })

    it('throws error on invalid schema diff', async () => {
      const sourceSchema = {
        type: 'object',
        properties: { asset: { type: 'string' }, placeholder: { type: 'string' } },
      } as JSONSchema
      const destinationSchema = {
        type: 'object',
        properties: { asset: { type: 'string' } },
      } as JSONSchema

      expect(async () => await ChassisHelper.validateSchemaDiff(sourceSchema, destinationSchema)).rejects.toThrow()
    })

    it('not throws error on invalid schema diff and throwable is to false', async () => {
      const sourceSchema = {
        type: 'object',
        properties: { asset: { type: 'string' }, placeholder: { type: 'string' } },
      } as JSONSchema
      const destinationSchema = {
        type: 'object',
        properties: { asset: { type: 'string' } },
      } as JSONSchema

      const result = await ChassisHelper.validateSchemaDiff(sourceSchema, destinationSchema, false)

      expect(result).toBe(false)
    })
  })

  describe('jsonStringify', () => {
    it('Convert a JSON object to string', () => {
      const json = { test: 'Chassis' }
      const expected = JSON.stringify(json, null, 2)

      expect(ChassisHelper.jsonStringify(json)).toBe(expected)
    })
  })

  describe('displayErrorTable', () => {
    it('display the error table', () => {
      const spy = jest.spyOn(console, 'log').mockImplementation()
      const errors: [string, string][] = [
        ['view type 1', 'error 1'],
        ['view type 2', 'error 2'],
      ]
      ChassisHelper.displayErrorTable(errors)

      expect(spy).toHaveBeenCalled()
      spy.mockRestore()
    })
  })

  describe('generateJsonSchemaBySymbol', () => {
    it('generate JSON schema of given symbol', async () => {
      const file = resolve('__testdata__/ViewSpec.ts')
      const symbol = 'Banner'

      const consoleSpy = jest.spyOn(console, 'log').mockImplementation(() => {})

      await ChassisHelper.generateJsonSchemaBySymbol(file, symbol)

      expect(consoleSpy).toBeDefined()
      expect(consoleSpy).toHaveBeenCalledWith(expect.stringContaining('{'))

      consoleSpy.mockRestore()
    })
  })

  describe('generateJsonSchemaFile', () => {
    const file = resolve('__testdata__/ViewSpec.ts')
    const output = resolve('__testdata__/file/')

    afterEach(() => {
      fs.readdirSync(output).forEach(fileName => fs.unlinkSync(resolve(`${output}/${fileName}`)))
    })

    it('generate JSON schema file for all spec', async () => {
      await ChassisHelper.generateJsonSchemaFile(file, '', output, true)

      const schemaFile = await promises.readFile(resolve(`${output}/Schema.json`), 'utf-8')
      const schema = JSON.parse(schemaFile)

      expect(schema).toBeDefined()
      expect(schema).not.toBeNull()
    })

    it('generate JSON schema file for a specific symbol', async () => {
      const symbol = 'Banner'

      await ChassisHelper.generateJsonSchemaFile(file, symbol, output)

      const schemaFile = await promises.readFile(resolve(`${output}/${symbol}.json`), 'utf-8')
      const schema = JSON.parse(schemaFile) as JSONSchema

      expect(schema).toBeDefined()
      expect(schema.type).toEqual('object')
      expect(schema.definitions).toBeDefined()
      expect(schema.properties).toBeDefined()
    })
  })
})
