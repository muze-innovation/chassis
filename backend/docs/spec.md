# Specification

A specification file for Chassis defines the `structure` and details of the views, attributes, and data used in a UI. It serves as a `blueprint` for rendering views and validates the data for correctness before it is used in the front-end.

## Overview

A specification file written in `TypeScript` is converted to a [JSON Schema](https://json-schema.org/) for validating [Source](../example/source.json) JSON data.

### Example Json Schema

- [ViewSpec](../example/spec/ViewSpec.json)
- [ResolverSpec](../example/spec/ResovlerSpec.json)
- [Banner](../example/spec/Banner.json)
- [ScreenSpec](../example/spec/ScreenSpec.json)

### Validation Tools

https://www.jsonschemavalidator.net/

## Base Spec

- [ChassisScreenSpec](#chassisscreenspec)
- [ChassisViewSpec](#chassisviewspec)
- [ChassisResolverSpec](#chassisresolverspec)

## Chassis Screen Spec

```ts
export interface ChassisScreenSpec {
  version: string
  name: string
  items: ChassisViewSpec[]
}
```

ChassisScreenSpec is used to define the structure and properties of the UI components to be rendered on a screen and to validate the data used to create the UI.

`version` - a string that represents the version of the specification file.
`name` - a string that provides a name for the screen.
`items` - an array of `ChassisViewSpec` objects that represent the individual UI components to be rendered on the screen.

Example source.json:

```json
{
  "version": "1.0.0",
  "name": "default-landing-page",
  "items": []
}
```

## Chassis View Spec

```ts
export interface ChassisViewSpec {
  id: string
  viewType: string
  attributes: ChassisViewAttribute
  parameters?: any
  payload?: any
  error?: ChassisError
}
```

The ChassisViewSpec interface defines the structure of a single item in the screen. It has the following properties:

| Field                   | Required | Description                                                                      |
| ----------------------- | :------: | -------------------------------------------------------------------------------- |
| id                      |   Yes    | Unique identifier for each item                                                  |
| viewType                |   Yes    | Specifies the type of component view [Banner, Quick Access, Shelf Content, etc.] |
| attributes              |   Yes    | Defines the visual style of the component                                        |
| attributes.heightPolicy |   Yes    | Specifies the height type of the view [fixed, ratio]                             |
| attributes.heightValue  |   Yes    | Defines the height value of the view [50, "16:9"]                                |
| parameters              |    No    | Additional data for rendering the component                                      |
| payload                 |    No    | Data required for the component, can be static or remote from source             |
| error                   |    No    | Defines the error type, can be "hide" or "error"                                 |

### View Spec

You can extend the ChassisViewSpec interface to create a specific view specification for a banner component. Here's an example:

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

### Chassis View Attribute

```ts
interface _ChassisViewAttribute {}

type ChassisViewAttribute = _ChassisViewAttribute & HeightPolicy

type HeightPolicy = FixedHeightPolicy | RatioHeightPolicy

interface FixedHeightPolicy {
  heightPolicy: 'fixed'
  heightValue: number
}

interface RatioHeightPolicy {
  heightPolicy: 'ratio'
  heightValue: string
}
```

ChassisViewAttribute is defines the visual style of the component. This allows the attributes property of the `ChassisViewSpec` interface.

There are two types of `HeightPolicy` that can be applied to a view,

- `FixedHeightPolicy` means heightValue is a number to set a fixed component height, e.g. `100`.

- `RatioHeightPolicy` means heightValue is a string for component height in ratio form, e.g. `4:1`.

### Chassis Error

```ts
interface ChassisError {
  errorType: 'hide' | 'error'
}
```

ChassisError defines an error that may occur while resolving data for the view. It has a single property `errorType` which can be either `hide` or `error`, indicating how the error should be handled.

## Chassis Resolver Spec

```ts
export interface ChassisResolverSpec {
  input?: any
  output: any
}
```

The ChassisResolverSpec interface defines two properties, `input` which is optional, and `output`, both of which are of type any, meaning they can hold any type of value.

### Resolver Spec

Extend the `ChassisResolverSpec` to write a resolver specification file. The file should contain require properties.

For example:

```ts
// ResolverSpec.ts
interface GetBanner extends ChassisResolverSpec {
  input: {
    slug: string
  }
  output: {
    asset: string
    placeholder: string
  }
}
```

### Chassis View Payload Static

```ts
interface ChassisViewPayloadStatic {
  type: 'static'
  data: any
}
```

The ChassisViewPayloadStatic interface defines a static payload with two properties: type, which is set to the string value "static", and data, which is of type any. This is used to validate the payload type as `static`.

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

### Chassis View Payload Remote

```ts
interface ChassisViewPayloadRemote {
  type: 'remote'
  resolvedWith: string
  input?: any
}
```

ChassisViewPayloadRemote defines a remote payload with type set to "remote", `resolvedWith` as a string mapping to the [Resolver spec](#chassisresolverspec) file, and an optional input of type any. It is used to validate the remote payload type.For example:

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
