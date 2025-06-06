---
slug: delete-a-scheduler-jobs-jobid
title: "DELETE /a/scheduler/jobs/{JobID}"
menu: "DELETE /a/scheduler/jobs/{JobID}"
language: und
menu_name: menu-dev-guide-v7

---







 
[Enterprise Only] Delete a job from the scheduler  


### Path Parameters

 - **JobID** (_string, required_) 

 - **CleanableJobs** (_boolean_) 




### Response Example (200)
Response Type /definitions/jobsDeleteJobResponse

```
{
  "DeleteCount": 10,
  "Success": true
}
```




