import { BaseShelf } from "./BaseShelf";

export interface Banner extends BaseShelf {
  viewType: "Banner";
  payload: BannerPayloadStatic | BannerPayloadRemote;
}

//// ViewType Banner and type static.
export interface BannerPayloadStatic {
  type: "static";
  data: BannerData;
}

export interface BannerData {
  asset: string;
  placeholder: string;
}

//// ViewType Banner and type remote.
export interface BannerPayloadRemote {
  type: "remote";
  resolvedWith: string;
  input: { slug: string };
}
