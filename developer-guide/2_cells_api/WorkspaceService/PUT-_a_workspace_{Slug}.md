---
slug: put-a-workspace-slug
title: "PUT /a/workspace/{Slug}"
menu: "PUT /a/workspace/{Slug}"
language: und
menu_name: menu-dev-guide-v7

---







 
Create or update a workspace  


### Body Parameters

Name | Description | Type | Required
---|---|---|---






### Response Example (200)
Response Type /definitions/idmWorkspace

```
{
  "Attributes": "string",
  "Description": "string",
  "Label": "string",
  "LastUpdated": 10,
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
  "PoliciesContextEditable": true,
  "RootNodes": {},
  "RootUUIDs": [
    "string"
  ],
  "Scope": "string",
  "Slug": "string",
  "UUID": "string"
}
```




