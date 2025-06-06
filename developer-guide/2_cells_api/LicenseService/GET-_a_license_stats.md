---
slug: get-a-license-stats
title: "GET /a/license/stats"
menu: "GET /a/license/stats"
language: und
menu_name: menu-dev-guide-v7

---







 
[Enterprise Only] Display statistics about licenses usage  


No Parameters



### Response Example (200)
Response Type /definitions/certLicenseStatsResponse

```
{
  "ActivePeers": "string",
  "ActiveUsers": "string",
  "License": {
    "AccountName": "string",
    "ExpireTime": 10,
    "Features": {},
    "Id": "string",
    "IssueTime": 10,
    "MaxPeers": "string",
    "MaxUsers": "string",
    "ServerDomain": "string"
  }
}
```




