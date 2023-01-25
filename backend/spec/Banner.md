# Banner-ViewSpec
```json
{
  "type": "object",
  "properties": {
    "id": {
      "type": "string"
    },
    "viewType": {
      "type": "string",
      "enum": [
        "Banner"
      ]
    },
    "parameters": {
      "type": "object",
      "properties": {
        "title": {
          "type": "string"
        }
      },
      "required": [
        "title"
      ]
    },
    "payload": {
      "type": "object",
      "properties": {
        "asset": {
          "type": "string"
        },
        "placeholder": {
          "type": "string"
        }
      },
      "required": [
        "asset",
        "placeholder"
      ]
    },
    "attributes": {
      "type": "object",
      "properties": {
        "heightPolicy": {
          "enum": [
            "fixed",
            "ratio"
          ],
          "type": "string"
        },
        "heightValue": {
          "type": "string"
        }
      },
      "required": [
        "heightPolicy",
        "heightValue"
      ]
    }
  },
  "required": [
    "attributes",
    "id",
    "viewType"
  ],
  "definitions": {
    "BaseShelfAttribute": {
      "type": "object",
      "properties": {
        "heightPolicy": {
          "enum": [
            "fixed",
            "ratio"
          ],
          "type": "string"
        },
        "heightValue": {
          "type": "string"
        }
      },
      "required": [
        "heightPolicy",
        "heightValue"
      ]
    },
    "HeightPolicy": {
      "enum": [
        "fixed",
        "ratio"
      ],
      "type": "string"
    }
  },
  "$schema": "http://json-schema.org/draft-07/schema#"
}
```