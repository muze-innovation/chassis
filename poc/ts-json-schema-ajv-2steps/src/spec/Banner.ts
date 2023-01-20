import { BaseShelf } from "./BaseShelf";

export interface Banner extends BaseShelf {
  viewType: "Banner";
  payload: BannerPayloadStatic | BannerPayloadRemote;
}

//// ViewType Banner and type static.
export interface BannerPayloadStatic {
  type: "static";
  data: BannerStaticData;
}

export interface BannerStaticData {
  asset: string;
  placeholder: string;
}

//// ViewType Banner and type remote.
export interface BannerPayloadRemote {
  type: "remote";
  resolvedWith: "get-banner";
}
