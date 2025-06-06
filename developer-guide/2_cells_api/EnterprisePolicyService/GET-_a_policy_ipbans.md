---
slug: get-a-policy-ipbans
title: "GET /a/policy/ipbans"
menu: "GET /a/policy/ipbans"
language: und
menu_name: menu-dev-guide-v7

---







 
[Enterprise Only] List banned IPs  


No Parameters



### Response Example (200)
Response Type /definitions/ipbanListBansCollection

```
{
  "Bans": [
    {
      "BanExpire": "string",
      "History": [
        {
          "Details": {},
          "IP": "string",
          "IsSuccess": true,
          "connectionTime": "string"
        }
      ],
      "IP": "string"
    }
  ]
}
```




