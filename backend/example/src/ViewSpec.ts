import type { ChassisViewSpec, ChassisScreenSpec } from 'chassis'

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
  parameters: {
    asset: string
    placeholder: string
  }
}

// TODO: Auto generated
interface FinalChassisViewSpec extends ChassisScreenSpec<QuickAccess | Banner> {
}