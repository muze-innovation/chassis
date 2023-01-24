import { BaseShelf } from "./BaseShelf";

export interface QuickAccess extends BaseShelf {
  viewType: "QuickAccess";
  payload: QuickAccessPayloadStatic | QuickAccessPayloadRemote;
}

//// ViewType QuickAccess and type static.
/**
 *
 *
 *
 * @additionalProperties false
 */
export interface QuickAccessPayloadStatic {
  type: "static";
  data: QuickAccessData;
}

export interface QuickAccessData {
  item: {
    title: string;
    asset: string;
  }[];
}

//// ViewType QuickAccess and type remote.
export interface QuickAccessPayloadRemote {
  type: "remote";
  resolvedWith: string;
}
