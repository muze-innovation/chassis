# ViewSpec
```json
{
  "anyOf": [
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
      ]
    },
    {
      "type": "object",
      "properties": {
        "id": {
          "type": "string"
        },
        "viewType": {
          "type": "string",
          "enum": [
            "QuickAccess"
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
            "item": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string"
                  },
                  "asset": {
                    "type": "string"
                  }
                },
                "required": [
                  "asset",
                  "title"
                ]
              }
            }
          },
          "required": [
            "item"
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
      ]
    }
  ],
  "definitions": {
    "Banner": {
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
      ]
    },
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
    },
    "QuickAccess": {
      "type": "object",
      "properties": {
        "id": {
          "type": "string"
        },
        "viewType": {
          "type": "string",
          "enum": [
            "QuickAccess"
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
            "item": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string"
                  },
                  "asset": {
                    "type": "string"
                  }
                },
                "required": [
                  "asset",
                  "title"
                ]
              }
            }
          },
          "required": [
            "item"
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
      ]
    },
    "QuickAccessItem": {
      "type": "object",
      "properties": {
        "title": {
          "type": "string"
        },
        "asset": {
          "type": "string"
        }
      },
      "required": [
        "asset",
        "title"
      ]
    }
  },
  "$schema": "http://json-schema.org/draft-07/schema#"
}
```