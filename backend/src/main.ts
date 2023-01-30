import Chassis from './handler/Chassis'
import { resolve } from 'path'
import { ChassisViewSpec } from '../src/spec/ChassisViewSpec'
import { ChassisResolverSpec } from '../src/spec/ChassisResolverSpec'

export default Chassis

async function bootstrap() {
  const chassis = new Chassis([
    resolve(__dirname, './ViewSpec.ts'),
    resolve(__dirname, './ResolverSpec.ts')
  ])

  // Validate
  chassis.validateSpec(resolve(__dirname, '../data/source.json'))

  // Get all json schema
  console.log(JSON.stringify(await chassis.generateJsonSchemaFile(), null, 2))
}

bootstrap()


export type {
  ChassisViewSpec,
  ChassisResolverSpec
}
