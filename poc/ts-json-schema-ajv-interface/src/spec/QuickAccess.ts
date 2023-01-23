import { BaseShelf, BaseShelfAttribute, BaseShelfPayload, DataSourceType, HeightPolicy } from "./BaseShelf";

export interface QuickAccess extends BaseShelf {
  id: string;
  viewType: "QuickAccess";
  attributes: Attributes;
  parameters: Parameters;
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
}

interface Data {
  item: ContentItem[];
}
interface ContentItem {
  title: string;
  asset: string;
}
