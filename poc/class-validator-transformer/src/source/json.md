```json
[
    // Base Component
    {
        "id": "<ID>",
        "viewType": "<VIEW_TYPE>",
        "data": {
            "type": "static | dynamic",
            "source": "<CONTENT_PROVIDER> | undefined",
            "slug": "<SPECIFIC_PROP> | undefined"
        },
        "attributes": {
            "margin": "s | m | l",
            "backgroudColor": "<HEX_CODE>"
        },
        "action": {
            "type": "url | deeplink | tel",
            "value": "<URL>",
            "text": "<TEXT> | undefined"
        } | undefined
    }
    // Banner
    {
        "viewType": "Banner",
        "data": {
            "type": "static | dynamic",
            "source": "recommendProvider | undefined",
            "slug": "best-seller | undefined",
            "asset": "<IMAGE_URL>",
            "placeholder": "<IMAGE_URL>"
        },
        "attributes": {
            "ratio": "16:9 | 1.78",
            "border_radius": "s | m | l",
            "margin": "s | m | l",
            "fit": "cover | contain"
        },
        "action": {
            "type": "url | deeplink | tel",
            "value": "<URL>"
        } | undefined
    },
    // Carousel Banner
    {
        "viewType": "carousel_banner",
        "data": {
            "type": "static | dynamic",
            "source": "recommendProvider | undefined",
            "slug": "best-seller | undefined",
            "assets": [
                // Banner
            ]
        },
        "attributes": {
            "ratio": "16:9 | 1.78",
            "margin": "s | m | l",
            "infinte_scroll": "true | false",
            "auto_scroll_interval_ms": "5000",
            "indicator": {
                "visible": "visible | invisible | gone",
                "selectColor": "<HEX_CODE>",
                "unselectColor": "<HEX_CODE>"
            } | undefined,
        },
        "action": {
            "type": "url | deeplink | tel",
            "value": "<URL>"
        } | null
    }
]
```