import Ajv from 'ajv'
import {
  BaseAction,
  BaseShelf,
  BaseShelfAttribute,
  BaseShelfDataSource,
} from './BaseShelf'
import { IsOptional, IsString, ValidateNested } from 'class-validator'
import { validationMetadatasToSchemas } from 'class-validator-jsonschema'

export default class Banner extends BaseShelf {
  @IsString()
  public id!: string

  @IsString()
  public viewType!: string

  @ValidateNested()
  public data!: BaseShelfDataSource

  @ValidateNested()
  public attribute!: BaseShelfAttribute

  @IsOptional()
  @ValidateNested()
  public action?: BaseAction

  public onValidate(): any {
    const baseShelfDataSourceSchema = validationMetadatasToSchemas(
      {}
    ).BaseShelfDataSource
    const baseShelfAttributeSchema = validationMetadatasToSchemas(
      {}
    ).BaseShelfAttribute
    const baseActionSchema = validationMetadatasToSchemas({}).BaseAction
    const bannerSchema = validationMetadatasToSchemas({}).Banner

    const schema = {
      ...bannerSchema,
      properties: {
        ...bannerSchema.properties,
        data: baseShelfDataSourceSchema,
        attribute: baseShelfAttributeSchema,
        action: baseActionSchema,
      },
    }

    console.log(JSON.stringify(schema, null, 2))
    // console.log(schema);
    // console.log(validationMetadatasToSchemas({}).BaseShelfDataSource);
    // console.log(validationMetadatasToSchemas({}).BaseShelfAttribute);
    // console.log(validationMetadatasToSchemas({}).BaseAction);

    const ajv = new Ajv()
    const valid = ajv.validate(schema, this)
    if (valid) {
      console.log('Validation succeeded.')
    } else {
      console.log('Validation failed. Errors: ', ajv.errors)
    }
  }
}
