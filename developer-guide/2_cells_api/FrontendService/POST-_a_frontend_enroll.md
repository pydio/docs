---
slug: post-a-frontend-enroll
title: "POST /a/frontend/enroll"
menu: "POST /a/frontend/enroll"
language: und
menu_name: menu-dev-guide-v7

---







 
Generic endpoint that can be implemented by 2FA systems for enrollment  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**EnrollInfo** |  | _object_ |   
**EnrollType** |  | _string_ |   


### Body Example
```
{
  "EnrollInfo": {},
  "EnrollType": "string"
}
```






### Response Example (200)
Response Type /definitions/restFrontEnrollAuthResponse

```
{
  "Info": {}
}
```




