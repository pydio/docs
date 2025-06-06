---
slug: get-a-user-meta-namespace
title: "GET /a/user-meta/namespace"
menu: "GET /a/user-meta/namespace"
language: und
menu_name: menu-dev-guide-v7

---







 
List defined meta namespaces  


No Parameters



### Response Example (200)
Response Type /definitions/restUserMetaNamespaceCollection

```
{
  "Namespaces": [
    {
      "Indexable": true,
      "JsonDefinition": "string",
      "Label": "string",
      "Namespace": "string",
      "Order": 10,
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
      "PoliciesContextEditable": true
    }
  ]
}
```




