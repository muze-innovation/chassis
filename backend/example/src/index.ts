import Chassis from 'chassis'
import { resolve } from 'path'

async function bootstrap() {
  // Initial Instance Chassis
  const chassis = new Chassis([resolve(__dirname, './ViewSpec.ts'), resolve(__dirname, './ResolverSpec.ts')])

  const jsonSchema = await chassis.generateJsonSchema('Banner')

  // Generate json schema method.
  console.log(JSON.stringify(jsonSchema, null, 2))

  // Valdiate spec
  await chassis.validateSpec(resolve(__dirname, '../source.json'))
}

bootstrap()
