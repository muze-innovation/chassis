import { BaseViewSpec } from './BaseViewSpec'

type ViewSpec = Banner | QuickAccess | ShelfContent

interface Banner extends BaseViewSpec {
  id: string
  viewType: 'Banner'
  parameters?: { title: string }
  payload: {
    asset: string
    placeholder: string
  }
}

interface QuickAccess extends BaseViewSpec {
  id: string
  viewType: 'QuickAccess'
  parameters?: {
    title: string
  }
  payload: {
    item: QuickAccessItem[]
  }
}

interface QuickAccessItem {
  title: string
  asset: string
}

interface ShelfContent extends BaseViewSpec {
  id: string
  viewType: 'ShelfContent'
  parameters?: {
    title: string
  }
  payload: {
    item: ShelfContentItem[]
  }
}

interface ShelfContentItem {
  title: string
  asset: string
}
