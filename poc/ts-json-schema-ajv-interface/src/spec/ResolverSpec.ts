export interface GetBanner {
  input: BannerInput;
  output: BannerOutput;
}

interface BannerInput {
  slug: string;
}

interface BannerOutput {
  asset: string;
  placeholder: string;
}

export interface GetQuickAccessItem {
  output: QuickAccessItemOutput;
}

interface QuickAccessItemOutput {
  item: ContentItem[];
}
interface ContentItem {
  title: string;
  asset: string;
}
