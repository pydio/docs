---
slug: get-a-config-ctl
title: "GET /a/config/ctl"
menu: "GET /a/config/ctl"
language: und
menu_name: menu-dev-guide-v7

---







 
List all services and their status  


No Parameters



### Response Example (200)
Response Type /definitions/restServiceCollection

```
{
  "Services": [
    {
      "Controllable": true,
      "Description": "string",
      "Metadata": {},
      "Name": "string",
      "RunningPeers": [
        {
          "Address": "string",
          "Id": "string",
          "Metadata": {},
          "Port": 10
        }
      ],
      "Status": "string",
      "Tag": "string",
      "Version": "string"
    }
  ],
  "Total": 10
}
```




