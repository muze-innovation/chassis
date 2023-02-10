# SOURCE JSON

## Overview

The Chassis uses a `source` JSON file as `input` to render views and components.

## Source File

The `source` file is JSON data used to create the front-end UI. The following code is an example of a [Source](../example/source.json) in JSON format:

```json
{
  "version": "1.0.0",
  "name": "default-landing-page",
  "items": [
    {
      "id": "promo_banner_mid_year",
      "viewType": "Banner",
      "attributes": {
        "heightPolicy": "ratio",
        "heightValue": "4:1",
        "color": "red"
      },
      "payload": {
        "type": "static",
        "data": {
          "asset": "asset.png",
          "placeholder": "lalala.png"
        }
      }
    },
    {
      "id": "promo_banner_mid_month",
      "viewType": "Banner",
      "attributes": {
        "heightPolicy": "ratio",
        "heightValue": "4:1",
        "color": "red"
      },
      "payload": {
        "type": "remote",
        "resolvedWith": "GetBanner",
        "input": {
          "slug": "best-seller"
        }
      }
    }
  ]
}
```

To validate the data in the `screen` section, use the [Screen Spec](./spec.md/#chassisscreenspec). Similarly, for the validation of `items` within the component, use the [Banner](../example/src/ViewSpec.ts) specifications.

```ts
// ViewSpec.ts
interface Banner extends ChassisViewSpec {
  id: string
  viewType: 'Banner'
  payload: {
    asset: string
    placeholder: string
  }
}
```

## Payload and Resolver

Chassis can rendering front-end UIs with `dynamic` data. It uses a `payload`, which is the data that creates the UI, and can be either `static` or `remote`.

### Static Payload

In Chassis, a `static` payload is when the data is `directly` provided in the [source](#source-file) JSON file. For example:

```json
{
  "payload": {
    "type": "static",
    "data": {
      "asset": "asset.png",
      "placeholder": "placeholder.png"
    }
  }
}
```

- `data` field holds the data for the front-end UI.

`Static` payload can be validated using the `payload` property in the [ViewSpec](./spec.md/#view-spec) file.

### Remote Payload

A `remote` payload in Chassis is a type of UI data that uses a resolver to validate `dynamic` values and ensure proper rendering of the front-end. For example:

```json
{
  "payload": {
    "type": "remote",
    "resolvedWith": "GetBanner",
    "input": {
      "slug": "best-seller"
    }
  }
}
```

It does not contain the `data` fields, unlike a [Static Payload](#static-payload)

- `resolvedWith` field to reference a [ResolverSpec](./spec.md/#resolver-spec) file.

The front-end uses `resolvedWith` field keys to resolve the `dynamic` data that the view component needs for rendering.

### Resolver

Chassis supports `dynamic` values through the use of a `resolver`.The resolver maps the specification to the `resolvedWith` field in the [Remote Payload](#remote-payload).

```json
"resolvedWith": "GetBanner"
```

The resolver allows the user to specify a [ResolverSpec](../example/src/ResolverSpec.ts) file for validation. For example:

```ts
// ResolverSpec.ts
interface GetBanner {
  input: {
    slug: string
  }
  output: {
    asset: string
    placeholder: string
  }
}
```

The resolver specification file defines the `output` type (asset or placeholder) to validate with the `payload` in the [ViewSpec](./spec.md/#view-spec).

By using the resolver, Chassis can validate `dynamic` payload data and ensure that the front-end UI is correctly rendered.
