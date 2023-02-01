import { resolve } from 'path'
import Chassis from './handler/Chassis'
import { ChassisViewSpec } from '../src/spec/ChassisViewSpec'
import { ChassisResolverSpec } from '../src/spec/ChassisResolverSpec'

export default Chassis

// function bootstrap() {
//   const chassis = new Chassis([resolve('./example/src/ViewSpec.ts'), resolve('./example/src/ResolverSpec.ts')])

//   // execute function what you want
// }


// bootstrap()

export type { ChassisViewSpec, ChassisResolverSpec }

