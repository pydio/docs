---
slug: post-a-auth-token-impersonate
title: "POST /a/auth/token/impersonate"
menu: "POST /a/auth/token/impersonate"
language: und
menu_name: menu-dev-guide-v7

---







 
Generate a personal access token  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**AutoRefresh** |  | _integer_ |   
**ExpiresAt** |  | _string_ |   
**Label** |  | _string_ |   
**Scopes** |  | _array_ |   
**UserLogin** |  | _string_ |   


### Body Example
```
{
  "AutoRefresh": 10,
  "ExpiresAt": "string",
  "Label": "string",
  "Scopes": [
    "string"
  ],
  "UserLogin": "string"
}
```






### Response Example (200)
Response Type /definitions/entPersonalAccessTokenResponse

```
{
  "AccessToken": "string"
}
```




