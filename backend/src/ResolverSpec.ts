import { BaseResolverSpec } from './spec/BaseResolverSpec'

type ResolverSpec = GetBanner | GetQuickAccessItem
interface GetBanner extends BaseResolverSpec {
  input: { slug: string }
  output: {
    asset: string
    placeholder: string
  }
}

interface GetQuickAccessItem extends BaseResolverSpec {
  output: {
    item: ContentItem[]
  }
}
interface ContentItem {
  title: string
  asset: string
}
