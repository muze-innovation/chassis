import { ChassisResolverSpec } from '../src/spec/ChassisResolverSpec'

type ResolverSpec = GetBanner | GetQuickAccessItem
interface GetBanner extends ChassisResolverSpec {
  input: {
    slug: string
  }
  output: {
    asset: string
    placeholder: string
  }
}

interface GetQuickAccessItem extends ChassisResolverSpec {
  output: {
    item: ContentItem[]
  }
}
interface ContentItem {
  title: string
  asset: string
}
