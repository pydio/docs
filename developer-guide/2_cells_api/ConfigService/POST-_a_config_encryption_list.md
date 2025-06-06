---
slug: post-a-config-encryption-list
title: "POST /a/config/encryption/list"
menu: "POST /a/config/encryption/list"
language: und
menu_name: menu-dev-guide-v7

---







 
List registered master keys  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**All** |  | _boolean_ |   


### Body Example
```
{
  "All": true
}
```






### Response Example (200)
Response Type /definitions/encryptionAdminListKeysResponse

```
{
  "Keys": [
    {
      "Content": "string",
      "CreationDate": 10,
      "ID": "string",
      "Info": {
        "Exports": [
          {
            "By": "string",
            "Date": 10
          }
        ],
        "Imports": [
          {
            "By": "string",
            "Date": 10
          }
        ]
      },
      "Label": "string",
      "Owner": "string"
    }
  ]
}
```




