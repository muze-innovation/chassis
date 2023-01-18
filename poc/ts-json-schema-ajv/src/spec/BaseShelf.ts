type DataSourceType = 'static' | 'dynamic'

export interface BaseShelf {
  id: string
  viewType: string
  parameters: any
  payload?: BaseShelfPayload
  attribute: BaseShelfAttribute
}

export interface BaseShelfPayload {
  type: DataSourceType
  resolvedWith?: string
  input?: any
  output?: any
}

export interface BaseShelfAttribute {
  heightPolicy?: 'fixed' | 'ratio' | 'wrap'
  heightValue?: string
}
