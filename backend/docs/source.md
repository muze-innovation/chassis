# SOURCE JSON

## Understanding Chassis Input and Output

Chassis is a framework that allows for the validation of front-end UI components. It uses two components, specification and source files, to validate the user interface (UI) and provide error handling.

### validation

Chassis validates the front-end UI using two components: Specification files and Source files. If the validation returns TRUE, the front end will correctly render the UI component using the source in JSON format.

## Source Files

The source file is JSON data used to create the front-end UI. The following code is an example of a source file in JSON format:

```json
// source.json
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

To validate the data in the screen section, use the [Screen Spec](./spec.md/#chassisscreenspec) criteria. Similarly, for the validation of items within the component, employ the Banner specifications.

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

Chassis Library is a front-end UI rendering tool that supports dynamic data. This document describes the payload and resolver functionality in Chassis.

The payload is a key component of the Chassis front-end UI. It is the data used to create the UI. The payload type can be either static or remote.

### Static Payload

In a static payload, the data is provided directly in the JSON format. For example:

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

### Remote Payload

A remote payload, on the other hand, does not have the asset and placeholder fields, but it includes a resolvedWith field that maps to the resolver specification file. For example:

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

### Resolver

Chassis supports dynamic values through the use of a resolver. The resolver allows the user to specify a resolver specification file for input/output validation. The resolver maps the specification to the resolvedWith field in the remote payload.

```json
"resolvedWith": "GetBanner"
```

The resolver specification file defines the output type (asset or placeholder) to validate with the payload in the main Banner specification.

For example, the resolver specification file ResolverSpec.ts:

```ts
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

By using the resolver, Chassis can validate dynamic payload data and ensure that the front-end UI is correctly rendered.

Chassis Library provides a flexible and dynamic approach to front-end UI rendering. With the use of payload and resolver, Chassis can handle static and dynamic data in a secure and efficient manner.
