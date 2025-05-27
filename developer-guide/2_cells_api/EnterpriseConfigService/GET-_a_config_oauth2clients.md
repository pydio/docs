---
slug: get-a-config-oauth2clients
title: "GET /a/config/oauth2clients"
menu: "GET /a/config/oauth2clients"
language: und
menu_name: menu-dev-guide-v7

---







 
[Enterprise Only] List oauth2 clients  


No Parameters



### Response Example (200)
Response Type /definitions/entOAuth2ClientCollection

```
{
  "staticClients": [
    {
      "audience": [
        "string"
      ],
      "client_id": "string",
      "client_name": "string",
      "client_secret": "string",
      "grant_types": [
        "string"
      ],
      "redirect_uris": [
        "string"
      ],
      "response_types": [
        "string"
      ],
      "scope": "string"
    }
  ]
}
```




