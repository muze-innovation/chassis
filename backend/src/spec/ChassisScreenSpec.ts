import type { ChassisViewSpec } from './ChassisViewSpec'

export interface ChassisScreenSpec<VS extends ChassisViewSpec> {
  version: string
  name: string
  items: VS[]
}
