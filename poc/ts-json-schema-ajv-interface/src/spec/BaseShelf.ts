import { Banner } from "./Banner";
import { QuickAccess } from "./QuickAccess";
import { ShelfContent } from "./ShelfContent";

export type DataSourceType = "static" | "remote";

export type HeightPolicy = "fixed" | "ratio" | "wrap";

export type ViewType = "Banner" | "ShelfContent" | "QuickAccess";

export type ShelfViewType = Banner | ShelfContent | QuickAccess;
export interface BaseShelf {
  id: string;
  viewType: ViewType;
  attributes: BaseShelfAttribute;
  parameters?: any;
  payload?: BaseShelfPayload;
}

export interface BaseShelfPayload {
  type: DataSourceType;
  data?: any;
  resolvedWith?: string;
  input?: any;
  output?: any;
}

export interface BaseShelfAttribute {
  heightPolicy: HeightPolicy;
  heightValue: string;
}
