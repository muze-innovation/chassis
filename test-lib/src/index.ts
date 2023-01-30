import Chassis from "chassis";
import { resolve } from 'path'

async function bootstrap() {
  const chassis = new Chassis([
    resolve(__dirname, './ViewSpec.ts'),
    resolve(__dirname, './ResolverSpec.ts')
  ])

  const isValid = await chassis.validateSpec(resolve(__dirname, '../source.json'))
  console.log(isValid)
}

bootstrap()

