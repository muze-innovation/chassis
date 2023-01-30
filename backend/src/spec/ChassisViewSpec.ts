export interface ChassisViewSpec {
  id: string
  viewType: string
  parameters?: any
  payload?: any
  error?: ChassisError
  attributes: ChassisViewAttribute
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
