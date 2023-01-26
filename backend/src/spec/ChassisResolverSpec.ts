export interface ChassisResolverSpec {
  input?: any
  output: any
}

interface ChassisViewPayloadStatic {
  type: 'static'
  data: any
}

interface ChassisViewPayloadRemote {
  type: 'remote'
  resolvedWith: string
  input?: any
}
