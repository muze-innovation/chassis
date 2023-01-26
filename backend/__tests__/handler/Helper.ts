import { JSONSchema } from '@apidevtools/json-schema-ref-parser'
import { Helper } from '../../src/handler/Helper'

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

      expect(Helper.validateJsonSchema(schema, json)).toBe(true)
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

      expect(Helper.validateJsonSchema(schema, json)).toBe(false)
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

      expect(() => Helper.validateJsonSchema(schema, json)).toThrow()
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

      expect(await Helper.validateSchemaDiff(sourceSchema, destinationSchema)).toBe(true)
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

      expect(await Helper.validateSchemaDiff(sourceSchema, destinationSchema)).toBe(false)
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

      expect(async () => await Helper.validateSchemaDiff(sourceSchema, destinationSchema)).rejects.toThrow()
    })
  })
})
