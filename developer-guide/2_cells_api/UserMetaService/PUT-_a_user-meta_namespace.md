---
slug: put-a-user-meta-namespace
title: "PUT /a/user-meta/namespace"
menu: "PUT /a/user-meta/namespace"
language: und
menu_name: menu-dev-guide-v7

---







 
Admin: update namespaces  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**Namespaces** |  | _array_ |   
**Operation** |  | _#/definitions/UpdateUserMetaNamespaceRequestUserMetaNsOp_ |   


### Body Example
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
  ],
  "Operation": "string"
}
```






### Response Example (200)
Response Type /definitions/idmUpdateUserMetaNamespaceResponse

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




