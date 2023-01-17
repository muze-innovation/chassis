type DataSourceType = 'static' | 'dynamic'
type BaseSize = 's' | 'm' | 'l' | 'xl'
type ActionType = 'url' | 'deeplink' | 'tel'

export abstract class BaseShelf {
  public abstract id: string

  public abstract viewType: string

  public abstract data: BaseShelfDataSource

  public abstract attribute: BaseShelfAttribute

  public action?: BaseAction

  public abstract onValidate(): boolean
}

export class BaseShelfDataSource {
  public type: DataSourceType = 'static'

  public source?: string

  public slug?: string
}

export class BaseShelfAttribute {
  public margin?: BaseSize

  public backgroundColor?: string
}

export class BaseAction {
  public type!: ActionType

  public value!: string

  public text?: string
}
