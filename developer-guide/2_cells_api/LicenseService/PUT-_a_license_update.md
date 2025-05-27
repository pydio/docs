---
slug: put-a-license-update
title: "PUT /a/license/update"
menu: "PUT /a/license/update"
language: und
menu_name: menu-dev-guide-v7

---







 
[Enterprise Only] Update License String  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**LicenseString** |  | _string_ |   


### Body Example
```
{
  "LicenseString": "string"
}
```






### Response Example (200)
Response Type /definitions/certPutLicenseInfoResponse

```
{
  "ErrorInvalid": true,
  "ErrorWrite": true,
  "Success": true
}
```




