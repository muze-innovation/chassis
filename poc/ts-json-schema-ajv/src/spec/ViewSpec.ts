import { BaseViewSpec, BaseViewPayloadRemote, BaseViewPayloadStatic } from "./BaseView"

type ViewSpec = Banner | QuickAccess | ShelfContent

interface Banner extends BaseViewSpec {
  viewType: 'Banner'
  payload: BannerPayloadStatic | BannerPayloadRemote
}

interface BannerPayloadStatic extends BaseViewPayloadStatic {
  data: { asset: string, placeholder: string }
}

interface BannerPayloadRemote extends BaseViewPayloadRemote {
  input: { slug: string }
}

interface QuickAccess extends BaseViewSpec {
  viewType: 'QuickAccess'
  payload: QuickAccessPayloadStatic | BaseViewPayloadRemote
}

interface QuickAccessPayloadStatic extends BaseViewPayloadStatic {
  data: { item: {title: string, asset: string }[] }
}

interface ShelfContent extends BaseViewSpec {
  viewType: 'ShelfContent'
}

