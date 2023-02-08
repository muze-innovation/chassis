import { ChassisResolverSpec, ChassisViewPayloadSource } from "./ChassisResolverSpec"

// Try using Generic Typing? e.g. interface ChassisViewSpec<ParamType, PayloadType> { .. }
export interface ChassisViewSpec<T> {
  id: string
  viewType: string
  parameters?: any
  payload?: T
  error?: ChassisError
  attributes: ChassisViewAttribute
}

interface ChassisViewDefinition<T> extends Omit<ChassisViewSpec<T>, 'payload'> {
  payload: ChassisViewPayloadSource<T>
}

interface FixedHeightPolicy {
  heightPolicy: 'fixed'
  heightValue: number
}

interface RatioHeightPolicy {
  heightPolicy: 'ratio'
  heightValue: string
}

type HeightPolicy = FixedHeightPolicy | RatioHeightPolicy

interface _ChassisViewAttribute {}

type ChassisViewAttribute = _ChassisViewAttribute & HeightPolicy

interface ChassisError {
  errorType: 'hide' | 'error'
}
