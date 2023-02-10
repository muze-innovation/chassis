# Specification

A Chassis `specification file` outlines the `structure` and components of a UI, serving as a blueprint for view rendering and data validation before it is displayed in the front-end.

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

- [Chassis Screen Spec](#chassisscreenspec)
- [Chassis View Spec](#chassisviewspec)
  - [View Spec](#view-spec)
  - [Chassis View Attribute](#chassis-view-attribute)
  - [Chassis Error](#chassis-error)
- [Chassis Resolver Spec](#chassisresolverspec)
  - [Resolver Spec](#resolver-spec)
- [Payload Spec](#payload-spec)
  - [Chassis View Payload Static](#chassis-view-payload-static)
  - [Chassis View Payload Remote](#chassis-view-payload-remote)

## Chassis Screen Spec

The `source` will be represented by a `screen` with item component views included.

Example source.json:

```json
{
  "version": "1.0.0",
  "name": "default-landing-page",
  "items": []
}
```

`ChassisScreenSpec` defines UI structure and properties for accurate `screen` rendering and data validation.You can view the spec in the [ChassisScreenSpec](../src/spec/ChassisScreenSpec.ts).

```ts
// ChassisScreenSpec.ts
export interface ChassisScreenSpec {
  version: string
  name: string
  items: ChassisViewSpec[]
}
```

- `version`: a string indicating the specification file version.
- `name`: a string naming the screen.
- `items`: an array of `ChassisViewSpec` objects representing UI components for screen rendering.

## Chassis View Spec

The ChassisViewSpec defines the structure of a single view item in the screen.

### View Spec

You can create a specific view specification for a `Banner` component by extending the `ChassisViewSpec`.Here's an example [ViewSpec](../example/src/ViewSpec.ts):

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

`ChassisViewSpec` provides the `base` properties for view specifications.You can view the spec in the [ChassisViewSpec](../src/spec/ChassisViewSpec.ts)

```ts
// ChassisViewSpec.ts
export interface ChassisViewSpec {
  id: string
  viewType: string
  attributes: ChassisViewAttribute
  parameters?: any
  payload?: any
  error?: ChassisError
}
```

It has the following properties:

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

### Chassis View Attribute

`ChassisViewAttribute` is defines the visual style of the component. This allows the attributes property of the `ChassisViewSpec`.

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

There are two types of `HeightPolicy` that can be applied to a view,

- `FixedHeightPolicy` means heightValue is a number to set a fixed component height, e.g. `100`.

- `RatioHeightPolicy` means heightValue is a string for component height in ratio form, e.g. `4:1`.

### Chassis Error

`ChassisError` handles UI display errors that result from data validation.

```ts
interface ChassisError {
  errorType: 'hide' | 'error'
}
```

The errorType property can either be set to `hide` or `error`.

## Chassis Resolver Spec

`ChassisResolverSpec` validates `dynamic` data for the front-end UI by mapping it to the `resolvedWith` field in the [Payload Remote](#chassis-view-payload-remote), ensuring the UI is rendered correctly with the right data.

### Resolver Spec

Write a `resolver specification` file by extending the `ChassisResolverSpec`.For example [ResolverSpec](../example/src/ResolverSpec.ts):

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

The required properties should be included in the file .You can view the spec in the [ChassisResolverSpec](../src/spec/ChassisResolverSpec.ts)

```ts
// ChassisResolverSpec.ts
export interface ChassisResolverSpec {
  input?: any
  output: any
}
```

The `ChassisResolverSpec` defines two properties:

- `input` optional property defines the properties of `input` required to resolve the data for the view component.
- `output` property defines the type of `output` returned from the resolver, which is used to validate the payload data required for displaying the UI of the view component.

## Payload Spec

### Chassis View Payload Static

In a `static` payload, the data is provided directly in the JSON format. For example:

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

`Static` payloads are useful when the data needed to render the UI is `already known`.

This is [ChassisViewPayloadStatic](../src/spec/ChassisResolverSpec.ts) that used to validate the payload type as `static`.

```ts
interface ChassisViewPayloadStatic {
  type: 'static'
  data: any
}
```

`ChassisViewPayloadStatic` defines a static payload with two properties:

- `type`, which is set to the string value `static`,
- `data` property is data for view component rendering.

### Chassis View Payload Remote

`Remote` payload enables `dynamic` rendering of UI with data not in `source` JSON, without the data field but with a `resolvedWith` field linking to the [Resolver Spec](#resolver-spec).

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

This is [ChassisViewPayloadRemote](../src/spec/ChassisResolverSpec.ts) that used to validate the payload type as `remote`.

```ts
interface ChassisViewPayloadRemote {
  type: 'remote'
  resolvedWith: string
  input?: any
}
```

`ChassisViewPayloadRemote` defines a remote payload with :

- `type` set to `remote`
- `resolvedWith` as a key string mapping to the [Resolver Spec](#resolver-spec) file
- `input` is optional and of type any. It validates remote payload and `resolves data` needed by the view component.
