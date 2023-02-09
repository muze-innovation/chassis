# Specification

## Overview

This spec use [JSON Schema](https://json-schema.org/) syntax for validate the json.

## Schema

- [ViewSpec](../example/spec/ViewSpec.json)
- [ResolverSpec](../example/spec/ResovlerSpec.json)
- [Banner](../example/spec/Banner.json)
- [ScreenSpec](../example/spec/ScreenSpec.json)

## Validation Tools

https://www.jsonschemavalidator.net/

## Example

[JSON Source/Output](../example/source.json)

### Default field

| Field                   | Required | Description                                                                      |
| ----------------------- | :------: | -------------------------------------------------------------------------------- |
| id                      |   Yes    | Unique identifier for each item                                                  |
| viewType                |   Yes    | Specifies the type of component view [Banner, Quick Access, Shelf Content, etc.] |
| attributes              |   Yes    | Defines the visual style of the component                                        |
| attributes.heightPolicy |   Yes    | Specifies the height type of the view [fixed, ratio]                             |
| attributes.heightValue  |   Yes    | Defines the height value of the view [50, "16:9"]                                |
| parameters              |    No    | Additional data for rendering the component                                      |
| payload                 |    No    | Data required for the component, can be static or remote from source             |
