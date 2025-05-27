---
slug: get-a-config-sites
title: "GET /a/config/sites"
menu: "GET /a/config/sites"
language: und
menu_name: menu-dev-guide-v7

---







 
[Enterprise Only] List configured sites  


No Parameters



### Response Example (200)
Response Type /definitions/entListSitesResponse

```
{
  "Sites": [
    {
      "Binds": [
        "string"
      ],
      "Certificate": {
        "CellsRootCA": "string",
        "CertFile": "string",
        "KeyFile": "string"
      },
      "LetsEncrypt": {
        "AcceptEULA": true,
        "Email": "string",
        "StagingCA": true
      },
      "Maintenance": true,
      "MaintenanceConditions": [
        "string"
      ],
      "ReverseProxyURL": "string",
      "SSLRedirect": true,
      "SelfSigned": {
        "Hostnames": [
          "string"
        ]
      }
    }
  ]
}
```




