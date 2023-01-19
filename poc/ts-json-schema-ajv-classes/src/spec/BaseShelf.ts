export type DataSourceType = "static" | "remote";

export type HeightPolicy = "fixed" | "ratio" | "wrap";

export type ViewType = "Banner" | "ShelfContent" | "QuickAccess";

export abstract class BaseShelf {
  abstract id: string;
  abstract viewType: ViewType;
  abstract attributes: BaseShelfAttribute;
  parameters?: any;
  payload?: BaseShelfPayload;
}

export class BaseShelfPayload {
  type!: DataSourceType;
  resolvedWith?: string;
  input?: any;
  output?: any;
}

export abstract class BaseShelfAttribute {
  abstract heightPolicy: HeightPolicy;
  abstract heightValue: string;
}
