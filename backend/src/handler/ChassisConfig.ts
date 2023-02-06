export default class ChassisConfig {
  // File name
  public static screenSpec = 'ChassisScreenSpec'
  public static viewSpec = 'ChassisViewSpec'
  public static resolverSpec = 'ChassisResolverSpec'
  public static viewPayloadStatic = 'ChassisViewPayloadStatic'
  public static viewPayloadRemote = 'ChassisViewPayloadRemote'
  // Path
  public static screenSpecPath = `../spec/${this.screenSpec}.ts`
  public static viewSpecPath = `../spec/${this.viewSpec}.ts`
  public static resolverSpecPath = `../spec/${this.resolverSpec}.ts`

  // Table of error
  public static columnJsonSchemaError: Record<string, string> = {
    instancePathCol: 'InstancePath',
    keywordCol: 'Keyword',
    paramsCol: 'Params',
    messageCol: 'Message',
    parentPathCol: 'ParentPath',
  }

  public static columnSchemaDiffError: Record<string, string> = {
    addedCol: 'AddedJsonSchema',
    removedCol: 'RemovedJsonSchema',
  }
  public static columnMainError: Record<string, string> = {
    viewTypeCol: 'ViewType',
    errorCol: 'Error',
  }
}
