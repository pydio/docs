---
slug: post-a-config-datasource-name
title: "POST /a/config/datasource/{Name}"
menu: "POST /a/config/datasource/{Name}"
language: und
menu_name: menu-dev-guide-v7

---







 
Create or update a datasource  


### Body Parameters

Name | Description | Type | Required
---|---|---|---






### Response Example (200)
Response Type /definitions/objectDataSource

```
{
  "ApiKey": "string",
  "ApiSecret": "string",
  "CreationDate": 10,
  "Disabled": true,
  "EncryptionKey": "string",
  "EncryptionMode": "string",
  "FlatStorage": true,
  "LastSynchronizationDate": 10,
  "Name": "string",
  "ObjectsBaseFolder": "string",
  "ObjectsBucket": "string",
  "ObjectsHost": "string",
  "ObjectsPort": 10,
  "ObjectsSecure": true,
  "ObjectsServiceName": "string",
  "PeerAddress": "string",
  "SkipSyncOnRestart": true,
  "StorageConfiguration": {},
  "StorageType": "string",
  "VersioningPolicyName": "string",
  "Watch": true
}
```




