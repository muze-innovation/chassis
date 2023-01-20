import { BaseShelf, BaseShelfAttribute, BaseShelfPayload, DataSourceType, HeightPolicy } from "./BaseShelf";

export interface ShelfContent extends BaseShelf {
  id: string;
  viewType: "ShelfContent";
  attributes: Attributes;
  parameters: Parameters;
  payload: Payload;
}

interface Attributes {
  heightPolicy: HeightPolicy;
  heightValue: string;
  color: string;
}

interface Parameters {
  title: string;
}

interface Payload {
  type: DataSourceType;
  data: Data;
  resolvedWith?: string | undefined;
}

interface Data {
  item: ContentItem[];
}

interface ContentItem {
  title: string;
  asset: string;
}
