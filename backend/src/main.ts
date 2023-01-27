import Chassis from './handler/Chassis'
import { resolve } from 'path'
import json from '../data/source.json'

function bootstrap(specPaths?: string[]) {
  // initial spec path
  const specPathResolves: string[] = [
    ...specPaths?.map(path => resolve(path)) ?? [],
    resolve('./src/ViewSpec.ts'),
    resolve('./src/ResolverSpec.ts')
  ]

  const chassis = new Chassis(specPathResolves)
  chassis.validateSpec(json)
}

// TODO:: This execute only develop mode when deploy will remove this
bootstrap()

export default bootstrap
