---
slug: post-a-auth-token-document
title: "POST /a/auth/token/document"
menu: "POST /a/auth/token/document"
language: und
menu_name: menu-dev-guide-v7

---







 
Generate a temporary access token for a specific document for the current user  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**ClientID** |  | _string_ |   
**Path** |  | _string_ |   


### Body Example
```
{
  "ClientID": "string",
  "Path": "string"
}
```






### Response Example (200)
Response Type /definitions/restDocumentAccessTokenResponse

```
{
  "AccessToken": "string"
}
```




