import Chassis from './handler/Chassis'
import { resolve } from 'path'
import json from '../data/source.json'

const chassis = new Chassis([resolve('./src/ViewSpec.ts'), resolve('./src/ResolverSpec.ts')])
chassis.validateSpec(json)
