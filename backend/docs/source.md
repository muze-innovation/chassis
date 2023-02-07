# SOURCE/OUTPUT JSON

### Default field

| Field                   | Mendatory |                                      Description                                       |
| ----------------------- | :-------: | :------------------------------------------------------------------------------------: |
| id                      |     Y     |                                  The ID of each item                                   |
| viewType                |     Y     | Component view type [Banner, Quick Access, Shelf Content, Search Bar, Feed Content...] |
| attributes              |     Y     |                The field is used to define the style of the component.                 |
| attributes.heightPolicy |     Y     |                           View height type [ fixed , ratio ]                           |
| attributes.heightValue  |     Y     |                             View height value [50, "16:9"]                             |
| parameters              |           |                         The field is used to display directly.                         |
| payload                 |           |   Data payloads that may need to be resolved (can be known by type static or remote)   |

## Example

[Specification](../example/spec/)
[JSON Source/Output](../example/source.json)

![ImageUi](../asset/ui.jpg)

## Input(Spec,Source)

Chassis input is comprised of two components: specification and source files.

### Display on UI

Example Banner :

![ImageBanner](../asset/banner.png)

Chassis validation of the front-end UI is based on the [Spec](#Spec) and [Source](#Source) files. If the validation returns `TRUE`, the front end will correctly render the `Banner` using the source in JSON format.

### Spec

The specification file validates the source format (JSON) as a TypeScript file.

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

`Banner` fields, like `id`, must be specific data types. Chassis displays error if source `id` (in JSON) is not a `string`.

### Source

The source file is JSON data used to create the front-end UI.

source.json

```json
{
  "version": "1.0.0",
  "name": "default-landing-page",
  "items": [
    {
      "id": "promo_banner_super_brand_day",
      "viewType": "Banner",
      "attributes": {
        "heightPolicy": "ratio",
        "heightValue": "4:1"
      },
      "parameter": {
        "title": "Special for you"
      },
      "payload": {
        "type": "static",
        "data": {
          "asset": "asset.png",
          "placeholder": "placeholder.png"
        }
      }
    }
  ]
}
```

This object uses `Banner` specifications to validate.

## Problem

Payload value may need resolving, `static` or `remote`. Normal specs can't validate `remote` type.

source.json

```json
{
  "id": "promo_banner_mid_month",
  "viewType": "Banner",
  "attributes": {
    "heightPolicy": "ratio",
    "heightValue": "4:1",
  },
  "parameter":{
    "title":"Best Seller"
  }
  "payload": {
    "type": "remote",
    "resolvedWith": "GetBanner",
      "input": {
        "slug": "best-seller"
      }
  }
}
```

The `remote` payload type does not have the `assets` and `placeholder` fields to validate with `Banner` specifications, but it has an `resolvedWith` field to handle with the resolver spec file.

## Solution

### Resolver

Chassis handles dynamic values through the use of `Resolver`. It allows the user to specify a resolver specification file for input/output validation by mapping the spec to the `resolvedWith` field.

```json
"resolvedWith": "GetBanner"
```

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

```ts
// ViewSpec.ts
interface Banner {
  id: string
  viewType: 'Banner'
  attributes: {
    heightPolicy: 'ratio'
    heightValue: string
  }
  parameter: {
    title: string
  }
  payload: {
    asset: string
    placeholder: string
  }
}
```

Resolver spec defines output type (asset or placeholder) to validate with payload in Banner spec.
