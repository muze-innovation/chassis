import Chassis from 'chassis'
import { resolve } from 'path'

async function main() {
  // Initial Instance Chassis
  const chassis = new Chassis([resolve(__dirname, './ViewSpec.ts'), resolve(__dirname, './ResolverSpec.ts')])

  // Validate spec
  console.log(await chassis.validateSpec(resolve(__dirname, '../source.json')))
}

main()
