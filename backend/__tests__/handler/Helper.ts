import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import ChassisHelper from '../../src/handler/ChassisHelper'

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
  })
})
