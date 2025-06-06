---
slug: post-a-auth-token-revoke
title: "POST /a/auth/token/revoke"
menu: "POST /a/auth/token/revoke"
language: und
menu_name: menu-dev-guide-v7

---







 
Revoke a JWT token  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**TokenId** | Pass a specific Token ID to be revoked. If empty, request will use current JWT | _string_ |   


### Body Example
```
{
  "TokenId": "string"
}
```






### Response Example (200)
Response Type /definitions/restRevokeResponse

```
{
  "Message": "string",
  "Success": true
}
```




