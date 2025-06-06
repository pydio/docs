---
slug: get-a-templates-meta
title: "GET /a/templates/meta"
menu: "GET /a/templates/meta"
language: und
menu_name: menu-dev-guide-v7

---







 
Store an arbitrary metadata template  


No Parameters



### Response Example (200)
Response Type /definitions/entListMetaTemplateResponse

```
{
  "Templates": [
    {
      "Label": "string",
      "Meta": "string",
      "Namespace": "string",
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
      "Uuid": "string"
    }
  ]
}
```




