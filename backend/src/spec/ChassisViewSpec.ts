export interface ChassisViewSpec {
  id: string
  viewType: string
  parameters?: any
  payload?: any
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
