import { resolve } from 'path'
import Chassis from './handler/Chassis'
import { ChassisViewSpec } from '../src/spec/ChassisViewSpec'
import { ChassisResolverSpec } from '../src/spec/ChassisResolverSpec'

export default Chassis

async function bootstrap() {
  const chassis = new Chassis([resolve('./example/src/ViewSpec.ts'), resolve('./example/src/ResolverSpec.ts')])

  // execute function what you want
  // await chassis.validateSpec(resolve(__dirname, '../example/source.json'))
  console.log(JSON.stringify(await chassis.generateJsonSchemaBySymbol("Banner"), null, 2))
}

// For develop
bootstrap()

export type { ChassisViewSpec, ChassisResolverSpec }
