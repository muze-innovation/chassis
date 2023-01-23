import { BaseShelf, BaseShelfAttribute, BaseShelfPayload, DataSourceType, HeightPolicy } from "./BaseShelf";

export interface Banner extends BaseShelf {
  id: string;
  viewType: "Banner";
  attributes: Attributes;
  parameters?: Parameters;
  payload: Payload;
}

interface Attributes {
  heightPolicy: HeightPolicy;
  heightValue: string;
}

interface Parameters {
  title: string;
}

interface Payload {
  type: DataSourceType;
  data?: Data;
  resolvedWith?: string | undefined;
  input?: any;
}

interface Data {
  asset: string;
  placeholder: string;
}
