import { validateSpec } from "chassis";
import { resolve } from 'path'

validateSpec(resolve(__dirname, '../source.json'), [
  resolve(__dirname, './ViewSpec.ts'),
  resolve(__dirname, './ResolverSpec.ts')
])
