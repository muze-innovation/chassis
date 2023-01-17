import {
  IsOptional,
  IsString,
  IsObject,
  ValidateNested,
} from "class-validator";
import { Type } from "class-transformer";
import {
  BaseAction,
  BaseShelf,
  BaseShelfAttribute,
  BaseShelfDataSource,
} from "./BaseShelf";
import "reflect-metadata";

export default class Banner extends BaseShelf {
  @IsString()
  public id!: string;

  @IsString()
  public viewType!: string;

  @IsObject()
  @ValidateNested()
  @Type(() => BaseShelfDataSource)
  public data!: BaseShelfDataSource;

  @IsObject()
  @ValidateNested()
  @Type(() => BaseShelfAttribute)
  public attribute!: BaseShelfAttribute;

  @IsOptional()
  @IsObject()
  @ValidateNested()
  @Type(() => BaseAction)
  public action?: BaseAction;
}
