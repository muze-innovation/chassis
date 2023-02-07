import { ChassisResolverSpec } from 'chassis'

interface GetBanner extends ChassisResolverSpec {
  input: {
    slug: string
  }
  output: {
    asset: string
    placeholder: string
  }
}
