import { IsOptional, IsString } from 'class-validator'

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
  @IsString()
  public type: DataSourceType = 'static'

  @IsString()
  @IsOptional()
  public source?: string

  @IsString()
  @IsOptional()
  public slug?: string
}

export class BaseShelfAttribute {
  @IsString()
  @IsOptional()
  public margin?: BaseSize

  @IsString()
  @IsOptional()
  public backgroundColor?: string
}

export class BaseAction {
  @IsString()
  public type!: ActionType

  @IsString()
  public value!: string

  @IsString()
  @IsOptional()
  public text?: string
}
