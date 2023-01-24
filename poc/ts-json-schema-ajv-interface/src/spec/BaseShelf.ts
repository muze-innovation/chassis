export type DataSourceType = "static" | "remote";
export type HeightPolicy = "fixed" | "ratio" | "wrap";
export type ViewType = "Banner" | "ShelfContent" | "QuickAccess";

export interface BaseShelf {
  id: string;
  viewType: ViewType;
  attributes: BaseShelfAttribute;
  payload?: any;
}

export interface BaseShelfAttribute {
  heightPolicy: HeightPolicy;
  heightValue: string;
}

interface BaseShelfStaticPayload {
  type: DataSourceType;
  data: any;
}

interface BaseShelfRemotePayload {
  type: DataSourceType;
  resolvedWith: string;
  input?: any;
}
