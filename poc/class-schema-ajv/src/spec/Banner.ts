import { BaseShelf } from './BaseShelf'
import Ajv from 'ajv'
import exampleData from '../source/example.json'
import 'reflect-metadata'
import { enums, prop, ref, schema, use } from 'class-schema'

type DataSourceType = 'static' | 'dynamic'
type BaseSize = 's' | 'm' | 'l' | 'xl'
type ActionType = 'url' | 'deeplink' | 'tel'

@schema()
export class BaseShelfDataSource {
  @enums(['static', 'dynamic'])
  public type: DataSourceType = 'static'

  @prop()
  public source?: string

  @prop()
  public slug?: string
}

@schema()
export class BaseShelfAttribute {
  @enums(['s', 'm', 'l', 'xl'])
  public margin?: BaseSize

  @prop()
  public backgroundColor?: string
}

@schema()
export class BaseAction {
  @enums(['url', 'deeplink', 'tel'])
  public type!: ActionType

  @prop()
  public value!: string

  @prop(String, { required: false })
  public text?: string
}

@schema()
export default class Banner extends BaseShelf {
  @prop()
  public id!: string

  @prop()
  public viewType!: string

  @ref(BaseShelfDataSource)
  public data!: BaseShelfDataSource

  @ref(BaseShelfAttribute)
  public attribute!: BaseShelfAttribute

  @ref(BaseAction, { required: false })
  public action?: BaseAction

  public onValidate(): boolean {
    // console.log(JSON.stringify(use(Banner)))
    // console.log(use(Banner))

    const ajv = new Ajv()
    const valid = ajv.validate(use(Banner), exampleData)
    if (!valid) {
      console.log('Validation failed. Errors: ', ajv.errors)
      return false
    } else {
      console.log('Validation succeeded.')
      return true
    }
  }
}
