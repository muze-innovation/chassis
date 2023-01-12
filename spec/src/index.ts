/**
 * Select key from the type `T` where its associated value matched `V`.
 */
type Selector<T, V> = {
  [K in keyof T]: T[K] extends V ? K : never
}[keyof T]

export type ValueType = 'string' | 'number' | 'map' | 'any' | 'string[]' | 'number[]' | 'map[]' | 'any[]'
export type ViewParameter = {
  type: ValueType
  // additional attribute to customize the given parameters.
}
export type ComponentViewParameters = Record<string, ViewParameter>
export type ComponentRenderingInputDataFormat = Record<string, ValueType>

/**
 * Describe the specification of each component to be provided by
 * the consumer's application.
 * 
 * Each component should be able to provide the 
 */
export interface ComponentSpec {
  /**
   * Represent the custom (additional) fields that the 
   * component specification (JSON) should provided.
   */
  customViewParameterType: ComponentViewParameters

  /**
   * Represent the data model that the
   * component required, and will be resolved when
   * application about to render the component.
   * 
   * This doesn't define how the payload is obtained. 
   * Rather it defines the format that the system need
   * to deliver to the Component when rendering phase happen.
   */
  payloadType: ComponentRenderingInputDataFormat
}

/**
 * Base interface to allow Application creator to create their
 * output specifications.
 */
export type RemoteSourceProviderSpec = Record<string, ValueType>

interface RemoteSource<DataType, ProvidedRemoteSource> {
  type: 'remote'
  resolveWith: Selector<DataType, ProvidedRemoteSource>
}

/**
 * Base interface to allow output specification to define output
 * value from the JSON outlet.
 */
interface StaticSource<DataType> {
  type: 'static'
  data: DataType
}

export type Source<DataType, ProvidedRemoteSource> = StaticSource<DataType> | RemoteSource<DataType, ProvidedRemoteSource>

// ---------------- Generated -------------------- //

export interface $generatedComponentName<$generatedComponentPayloadType, $providedRemoteSourceType extends RemoteSourceProviderSpec> {
  /**
   * Unique key that use to identify the component type
   */
  viewType: '$generatedViewTypeKey'

  /**
   * Where to obtain the input source
   */
  source: Source<$providedRemoteSourceType, $generatedComponentPayloadType>
}