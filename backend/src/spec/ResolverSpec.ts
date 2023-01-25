type ResolverSpec = GetBanner | GetQuickAccessItem;
export interface GetBanner {
  input: { slug: string };
  output: {
    asset: string;
    placeholder: string;
  };
}
export interface GetQuickAccessItem {
  output: {
    item: ContentItem[];
  };
}
interface ContentItem {
  title: string;
  asset: string;
}
