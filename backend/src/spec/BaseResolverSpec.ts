export interface BaseResolverSpec {
  input?: any
  output: any
}

interface BaseViewPayloadStatic {
  type: 'static'
  data: any
}

interface BaseViewPayloadRemote {
  type: 'remote'
  resolvedWith: string
  input?: any
}
