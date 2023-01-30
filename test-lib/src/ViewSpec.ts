import { ChassisViewSpec } from 'chassis'

type ViewSpec = Banner | QuickAccess | ShelfContent

interface Banner extends ChassisViewSpec {
  id: string
  viewType: 'Banner'
  payload: {
    asset: string
    placeholder: string
  }
}

interface QuickAccess extends ChassisViewSpec {
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

interface ShelfContent extends ChassisViewSpec {
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
