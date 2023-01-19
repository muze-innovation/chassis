import { BaseResolverSpec } from "./BaseResolver"

type ResolverSpec = GetBannerResolver | GetQuickAccessResolver 

export interface GetBannerResolver extends BaseResolverSpec {
  input: { slug: string }
  output: { asset: string, placeholder: string }
}

export interface GetQuickAccessResolver extends BaseResolverSpec {
  output: { item: {title: string, asset: string }[] }
}
