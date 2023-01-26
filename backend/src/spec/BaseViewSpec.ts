export interface BaseViewSpec {
  id: string
  viewType: string
  parameters?: any
  payload?: any
  attributes: BaseViewAttribute
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

interface _BaseViewAttribute {}

type BaseViewAttribute = _BaseViewAttribute & HeightPolicy
