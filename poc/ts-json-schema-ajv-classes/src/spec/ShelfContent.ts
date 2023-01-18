import {
  BaseShelf,
  BaseShelfAttribute,
  BaseShelfPayload,
  DataSourceType,
  HeightPolicy,
} from "./BaseShelf";

export class ShelfContent extends BaseShelf {
  id!: string;
  viewType!: "ShelfContent";
  attributes!: Attributes;
  parameters!: Parameters;
  payload!: Payload;
}

class Attributes implements BaseShelfAttribute {
  heightPolicy!: HeightPolicy;
  heightValue!: string;
  color!: string;
}

class Parameters {
  title!: string;
}

class Payload implements BaseShelfPayload {
  type!: DataSourceType;
  input?: any;
}
