---
slug: post-a-templates-node
title: "POST /a/templates/node"
menu: "POST /a/templates/node"
language: und
menu_name: menu-dev-guide-v7

---







 
Create a template from a specific node  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**Policies** | Optional policies | _array_ |   
**RefNodeUuid** |  | _string_ |   
**TplLabel** |  | _string_ |   


### Body Example
```
{
  "Policies": [
    {
      "Action": "string",
      "Effect": "string",
      "JsonConditions": "string",
      "Resource": "string",
      "Subject": "string",
      "id": "string"
    }
  ],
  "RefNodeUuid": "string",
  "TplLabel": "string"
}
```






### Response Example (200)
Response Type /definitions/entCreateNodeTemplateResponse

```
{
  "Success": true,
  "TemplateUuid": "string"
}
```




