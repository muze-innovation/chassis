export default class ChassisConfig {
  // File name
  public static screenSpec = 'ChassisScreenSpec'
  public static viewSpec = 'ChassisViewSpec'
  public static resolverSpec = 'ChassisResolverSpec'
  public static viewPayloadStatic = 'ChassisViewPayloadStatic'
  public static viewPayloadRemote = 'ChassisViewPayloadRemote'
  // Path
  public static screenSpecPath = `./src/spec/${this.screenSpec}.ts`
  public static viewSpecPath = `./src/spec/${this.viewSpec}.ts`
  public static resolverSpecPath = `./src/spec/${this.resolverSpec}.ts`
}
