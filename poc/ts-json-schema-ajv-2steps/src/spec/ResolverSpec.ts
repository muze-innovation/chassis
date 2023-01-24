export interface GetBannerResolver {
  asset: string;
  placeholder: string;
}

export interface GetQuickAccessResolver {
  item: { title: string; asset: string }[];
}
