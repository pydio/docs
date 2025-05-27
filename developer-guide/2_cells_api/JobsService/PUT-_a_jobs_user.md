---
slug: put-a-jobs-user
title: "PUT /a/jobs/user"
menu: "PUT /a/jobs/user"
language: und
menu_name: menu-dev-guide-v7

---







 
Send Control Commands to one or many jobs / tasks  


### Body Parameters

Name | Description | Type | Required
---|---|---|---
**Cmd** | Type of command to send (None, Pause, Resume, Stop, Delete, RunOnce, Inactive, Active) | _#/definitions/jobsCommand_ |   
**JobId** | Id of the job | _string_ |   
**OwnerId** | Owner of the job | _string_ |   
**RunParameters** | Parameters used for RunOnce command | _object_ |   
**TaskId** | Id of the associated task | _string_ |   


### Body Example
```
{
  "Cmd": "string",
  "JobId": "string",
  "OwnerId": "string",
  "RunParameters": {},
  "TaskId": "string"
}
```






### Response Example (200)
Response Type /definitions/jobsCtrlCommandResponse

```
{
  "Msg": "string"
}
```




