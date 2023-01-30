import Chassis from "chassis";
import { resolve } from 'path'

async function bootstrap() {
  // Initial Instance Chassis
  const chassis = new Chassis([
    resolve(__dirname, './ViewSpec.ts'),
    resolve(__dirname, './ResolverSpec.ts')
  ])

  // Generate json schema method.
  console.log(await chassis.generateJsonSchema("Banner"))

  // Valdiate spec
  await chassis.validateSpec(resolve(__dirname, '../source.json'))
}

bootstrap()

