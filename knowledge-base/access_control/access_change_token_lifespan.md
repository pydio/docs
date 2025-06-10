---
slug: changing-token-lifespan
title: "Changing Token Lifespan"
description: "Quick tip explaining how to change the default authentication token TTL."
language: und
category: Access Control

---
Token lifespan (typically the JWT token) can be configured in the main pydio.json

```json
{
    "services": {
        ...
        "pydio.web.oauth": {
            ...
            "accessTokenLifespan": "10m",
            "refreshTokenLifespan": "60d"
        }
    }
}
```

Make sure to restart afterward.

Note: the refresh token can be used only once.