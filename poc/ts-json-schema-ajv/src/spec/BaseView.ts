
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


export interface BaseViewAttribute {
  heightPolicy?: 'fixed' | 'ratio' 
  heightValue?: string
}
