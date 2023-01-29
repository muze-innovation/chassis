import Chassis from './handler/Chassis'
import { readFileSync } from 'fs'
import { resolve } from 'path'
import { ChassisViewSpec } from '../src/spec/ChassisViewSpec'
import { ChassisResolverSpec } from '../src/spec/ChassisResolverSpec'

const validateSpec = (sourcePath: string, specPaths?: string[]) => {
  // initial spec path
  const specPathResolves: string[] = [
    ...specPaths?.map(path => resolve(path)) ?? [],
  ]

  const chassis = new Chassis(specPathResolves)

  const json = readFileSync(sourcePath, 'utf8')

  chassis.validateSpec(JSON.parse(json))
}

export {
  validateSpec,
}

export type {
  ChassisViewSpec,
  ChassisResolverSpec
}
