import Chassis from './handler/Chassis'
import { resolve } from 'path'
import json from '../data/source.json'

function bootstrap(specPaths?: string[]) {
  // initial spec path
  let specPathResolvers: string[] | [] = []

  // spec path guard
  if (specPaths && specPaths.length) {
    // loop spec path with resolve path
    specPathResolvers = specPaths.map(path => resolve(path))
  }

  const chassis = new Chassis([...specPathResolvers, resolve('./src/ViewSpec.ts'), resolve('./src/ResolverSpec.ts')])
  chassis.validateSpec(json)
}

// TODO:: This execute only develop mode when deploy will remove this
bootstrap()

export default bootstrap
