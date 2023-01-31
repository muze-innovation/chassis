import Chassis from '@/src/handler/Chassis'
import { resolve } from 'path'

import generateJsonSchemaBySymbol from '@/__testdata__/generateJsonSchemaBySymbol.json'

describe('Chassis', () => {
  let chassis: Chassis

  beforeAll(() => {
    // initial spec path
    const specPathResolves: string[] = [resolve('__testdata__/ViewSpec.ts'), resolve('__testdata__/ResolverSpec.ts')]
    chassis = new Chassis(specPathResolves)
  })

  describe('generate JSON Schema', () => {
    it('valid', async () => {
      const schema = await chassis.generateJsonSchemaBySymbol('ViewSpec')
      expect(schema).toEqual(generateJsonSchemaBySymbol)
    })
  })

  describe('validateScreenSpec', () => {
    it('valid screen spec', async () => {
      const sourceJson = {
        version: '1.0.0',
        name: 'default-landing-page',
        items: [
          {
            id: 'recent_orders_shelf_content',
            viewType: 'ShelfContent',
            attributes: {
              heightPolicy: 'fixed',
              heightValue: 100,
              color: 'red',
            },
            parameters: {
              title: 'Recent orders',
            },
            payload: {
              type: 'static',
              data: {
                item: [
                  {
                    title: 'ตามใจสั่ง ลาดพร้าว48',
                    asset: 'thai-restaurant-001.png',
                  },
                  {
                    title: 'Texas Chicken',
                    asset: 'texas-chicken.png',
                  },
                ],
              },
            },
          },
        ],
      }

      const result = await chassis.validateScreenSpec(sourceJson)

      expect(result).toBe(true)
    })

    it('throws error on invalid screen spec', async () => {
      const sourceJson = {
        id: 'recent_orders_shelf_content',
        viewType: 'ShelfContent',
        attributes: {
          heightPolicy: 'fixed',
          heightValue: 100,
          color: 'red',
        },
        parameters: {
          title: 'Recent orders',
        },
        payload: {
          type: 'static',
          data: {
            item: [
              {
                title: 'ตามใจสั่ง ลาดพร้าว48',
                asset: 'thai-restaurant-001.png',
              },
              {
                title: 'Texas Chicken',
                asset: 'texas-chicken.png',
              },
            ],
          },
        },
      }

      expect(async () => await chassis.validateScreenSpec(sourceJson)).rejects.toThrow()
    })
  })

  describe('validateViewSpec', () => {
    it('valid view spec', async () => {
      const sourceJson = {
        version: '1.0.0',
        name: 'default-landing-page',
        items: [
          {
            id: 'recent_orders_shelf_content',
            viewType: 'ShelfContent',
            attributes: {
              heightPolicy: 'fixed',
              heightValue: 100,
              color: 'red',
            },
            parameters: {
              title: 'Recent orders',
            },
            payload: {
              type: 'static',
              data: {
                item: [
                  {
                    title: 'ตามใจสั่ง ลาดพร้าว48',
                    asset: 'thai-restaurant-001.png',
                  },
                  {
                    title: 'Texas Chicken',
                    asset: 'texas-chicken.png',
                  },
                ],
              },
            },
          },
        ],
      }
      const result = await chassis.validateViewSpec(sourceJson)

      expect(result).toBe(true)
    })

    it('throws error when json.items is not found', async () => {
      const sourceJson = {}

      expect(async () => await chassis.validateViewSpec(sourceJson)).rejects.toThrow()
    })

    it('throws error when the unknown value heightPolicy in attributes is not in view spec', async () => {
      const sourceJson = {
        version: '1.0.0',
        name: 'default-landing-page',
        items: [
          {
            id: 'recent_orders_shelf_content',
            viewType: 'ShelfContent',
            attributes: {
              heightPolicy: 'dumpHeightPolicy',
              heightValue: 100,
              color: 'red',
            },
            parameters: {
              title: 'Recent orders',
            },
            payload: {
              type: 'static',
              data: {
                item: [
                  {
                    title: 'ตามใจสั่ง ลาดพร้าว48',
                    asset: 'thai-restaurant-001.png',
                  },
                  {
                    title: 'Texas Chicken',
                    asset: 'texas-chicken.png',
                  },
                ],
              },
            },
          },
        ],
      }

      expect(async () => await chassis.validateViewSpec(sourceJson)).rejects.toThrow()
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
      expect(
        async () => await chassis.validateSpec(resolve('__testdata__/spec/unknown-view-type.json'))
      ).rejects.toThrow()
    })
  })

  describe('validateResolverSpec', () => {
    it('throws error for unknown payload type', async () => {
      expect(
        async () => await chassis.validateSpec(resolve('__testdata__/resolverSpec/unknown-payload-type.json'))
      ).rejects.toThrow()
    })

    describe('viewType is Banner', () => {
      describe('static payload', () => {
        it('missing asset property in items of schema path', async () => {
          expect(
            async () => await chassis.validateSpec(resolve('__testdata__/banner/static-payload.json'))
          ).rejects.toThrow()
        })
      })

      describe('remote payload', () => {
        it('throws error invalid ResolverSpec', async () => {
          expect(
            async () => await chassis.validateSpec(resolve('__testdata__/banner/invalid-resolver-spec.json'))
          ).rejects.toThrow()
        })

        it('missing slug property in input node', async () => {
          expect(
            async () => await chassis.validateSpec(resolve('__testdata__/banner/missing-slug-property.json'))
          ).rejects.toThrow()
        })

        it('slug property is not string in input node', async () => {
          expect(
            async () => await chassis.validateSpec(resolve('__testdata__/banner/slug-property-is-not-string.json'))
          ).rejects.toThrow()
        })
      })
    })

    describe('viewType is QuickAccess', () => {
      describe('static payload', () => {
        it('missing asset property in items of schema path', async () => {
          expect(
            async () => await chassis.validateSpec(resolve('__testdata__/quickAccess/missing-asset-property.json'))
          ).rejects.toThrow()
        })
      })

      describe('remote payload', () => {
        it('throws error invalid ResolverSpec', async () => {
          expect(
            async () => await chassis.validateSpec(resolve('__testdata__/quickAccess/invalid-resolver-spec.json'))
          ).rejects.toThrow()
        })
      })
    })

    describe('viewType is ShelfContent', () => {
      describe('static payload', () => {
        it('missing title property in items of schema path', async () => {
          expect(
            async () => await chassis.validateSpec(resolve('__testdata__/shelfContent/missing-title-property.json'))
          ).rejects.toThrow()
        })
      })
    })
  })
})
