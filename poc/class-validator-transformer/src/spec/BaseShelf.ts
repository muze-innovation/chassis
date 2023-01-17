import {
  IsIn,
  IsOptional,
  IsString,
  validateSync,
  IsObject,
  ValidateNested,
} from "class-validator";
import { Type } from "class-transformer";
import "reflect-metadata";

type DataSourceType = "static" | "dynamic";
type BaseSize = "s" | "m" | "l" | "xl";
type ActionType = "url" | "deeplink" | "tel";
type DataSlug = "get-user-name";

export abstract class BaseShelf {
  public abstract id: string;
  public abstract viewType: string;
  public abstract data: BaseShelfDataSource;
  public abstract attribute: BaseShelfAttribute;
  public action?: BaseAction;

  public onValidate(): boolean {
    const errors = validateSync(this);
    if (errors.length > 0) {
      console.log(
        "Validation failed. Errors: ",
        JSON.stringify(errors[0], null, 2)
      );
      return false;
    } else {
      console.log("Validation succeeded.");
      return true;
    }
  }
}

export class BaseShelfDataSource {
  @IsIn(["static", "dynamic"])
  @IsString()
  public type: DataSourceType = "static";

  @IsOptional()
  @IsObject()
  @ValidateNested()
  @Type(() => Source)
  public source?: Source;

  @IsIn(["get-user-name"])
  @IsOptional()
  @IsString()
  public slug?: DataSlug;
}

class Source {
  @IsOptional()
  @IsString()
  customerName?: string;
}

export class BaseShelfAttribute {
  @IsIn(["s", "m", "l", "xl"])
  @IsOptional()
  @IsString()
  public margin?: BaseSize;

  @IsOptional()
  @IsString()
  public backgroundColor?: string;
}

export class BaseAction {
  @IsIn(["url", "deeplink", "tel"])
  @IsString()
  public type!: ActionType;

  @IsString()
  @IsString()
  public value!: string;

  @IsOptional()
  @IsString()
  public text?: string;
}
