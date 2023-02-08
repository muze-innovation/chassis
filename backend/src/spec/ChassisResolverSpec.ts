export interface ChassisResolverSpec {
  input?: any
  output: any
}

interface ChassisViewPayloadStatic<T> {
  type: 'static'
  data: T
}

type Resolver = {
  getBanner: {
    input: {},
    output: {
      link: string
    },
  },
  getPrompt: {
    input: string
    output: {
      username: string
    }
  },
  anotherPrompt: {
    input: string
    output: {
      username: string
    }
  },
}

type ResolverOf<OT, K extends keyof Resolver = keyof Resolver> = {
  [K in keyof Resolver]: Resolver[K]["output"] extends OT ? K : never
}[K]

type A = ResolverOf<{ username: string }>

interface ChassisViewPayloadRemote<T> {
  type: 'remote'
  resolvedWith: ResolverOf<T>
  input?: any
}

export type ChassisViewPayloadSource<T> = ChassisViewPayloadStatic<T> | ChassisViewPayloadRemote<T>
