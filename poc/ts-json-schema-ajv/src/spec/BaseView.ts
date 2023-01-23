
export interface BaseViewSpec {
  id: string
  viewType: string
  parameters?: any
  payload?: BaseViewPayloadStatic | BaseViewPayloadRemote
  attributes: BaseViewAttribute
}

export interface BaseViewPayloadStatic  {
  /**
  * @title StaticPayload#
  */
  type: 'static'
  data: any
}

export interface BaseViewPayloadRemote {
  /**
  * @title RemotePayload#
  */
  type: 'remote'
  resolvedWith: string
  input?: any
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

interface _BaseViewAttribute {
  version: string
}

export type BaseViewAttribute = _BaseViewAttribute & HeightPolicy
