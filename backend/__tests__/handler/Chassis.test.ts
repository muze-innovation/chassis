import Chassis from '@/src/handler/Chassis'
import { resolve } from 'path'

import generateJsonSchemaBySymbol from '@/__testdata__/generateJsonSchemaBySymbol.json'
import validScreenSpec from '@/__testdata__/spec/valid-screen-spec.json'
import inValidScreenSpec from '@/__testdata__/spec/invalid-screen-spec.json'
import validViewSpec from '@/__testdata__/spec/valid-view-spec.json'
import unknownHeightPolicyInAttributes from '@/__testdata__/spec/unknown-height-policy-in-attributes.json'

describe('Chassis', () => {
  let chassis: Chassis

  beforeAll(() => {
    // initial spec path
    const specPathResolves: string[] = [resolve('__testdata__/ViewSpec.ts'), resolve('__testdata__/ResolverSpec.ts')]
    chassis = new Chassis(specPathResolves)
  })

  beforeEach(() => {
    chassis['_errors'] = []
  })

  describe('generate JSON Schema', () => {
    it('valid', async () => {
      const schema = await chassis.generateJsonSchemaBySymbol('ViewSpec')
      expect(schema).toEqual(generateJsonSchemaBySymbol)
    })
  })

  describe('validateScreenSpec', () => {
    it('valid screen spec', async () => {
      const result = await chassis.validateScreenSpec(validScreenSpec)
      expect(result).toBe(true)
    })

    it('throws error on invalid screen spec', async () => {
      const result = await chassis.validateScreenSpec(inValidScreenSpec)
      expect(result).toBe(false)
    })
  })

  describe('validateViewSpec', () => {
    it('valid view spec', async () => {
      const result = await chassis.validateViewSpec(validViewSpec)
      expect(result).toBe(true)
    })

    it('throws error when json.items is not found', async () => {
      expect(async () => await chassis.validateViewSpec({})).rejects.toThrow()
    })

    it('throws error when the unknown value heightPolicy in attributes is not in view spec', async () => {
      const result = await chassis.validateViewSpec(unknownHeightPolicyInAttributes)
      expect(result).toBe(false)
    })
  })

  describe('validateSpec', () => {
    it('return true for valid input', async () => {
      const result = await chassis.validateSpec(resolve('__testdata__/spec/valid-input.json'))
      expect(result).toBe(true)
    })

    it('throws error for invalid input', async () => {
      expect(async () => await chassis.validateSpec(resolve('__testdata__/spec/invalid-input.json'))).rejects.toThrow()
    })

    it('throws error for unknown view type', async () => {
      const result = await chassis.validateSpec(resolve('__testdata__/spec/unknown-view-type.json'))
      expect(result).toBe(false)
    })
  })

  describe('validateResolverSpec', () => {
    it('throws error for unknown payload type', async () => {
      const result = await chassis.validateSpec(resolve('__testdata__/spec/unknown-payload-type.json'))
      expect(result).toBe(false)
    })
    describe('viewType is Banner', () => {
      describe('static payload', () => {
        it('missing asset property in items of schema path', async () => {
          const result = await chassis.validateSpec(resolve('__testdata__/banner/static-payload.json'))
          expect(result).toBe(false)
        })
      })
      describe('remote payload', () => {
        it('throws error invalid ResolverSpec', async () => {
          const result = await chassis.validateSpec(resolve('__testdata__/banner/invalid-resolver-spec.json'))
          expect(result).toBe(false)
        })
        it('missing slug property in input node', async () => {
          const result = await chassis.validateSpec(resolve('__testdata__/banner/missing-slug-property.json'))
          expect(result).toBe(false)
        })
        it('slug property is not string in input node', async () => {
          const result = await chassis.validateSpec(resolve('__testdata__/banner/slug-property-is-not-string.json'))
          expect(result).toBe(false)
        })
      })
    })
    describe('viewType is QuickAccess', () => {
      describe('static payload', () => {
        it('missing asset property in items of schema path', async () => {
          const result = await chassis.validateSpec(resolve('__testdata__/quickAccess/missing-asset-property.json'))
          expect(result).toBe(false)
        })
      })
      describe('remote payload', () => {
        it('throws error invalid ResolverSpec', async () => {
          const result = await chassis.validateSpec(resolve('__testdata__/quickAccess/invalid-resolver-spec.json'))
          expect(result).toBe(false)
        })
      })
    })
    describe('viewType is ShelfContent', () => {
      describe('static payload', () => {
        it('missing title property in items of schema path', async () => {
          const result = await chassis.validateSpec(resolve('__testdata__/shelfContent/missing-title-property.json'))
          expect(result).toBe(false)
        })
      })
    })
  })
})
