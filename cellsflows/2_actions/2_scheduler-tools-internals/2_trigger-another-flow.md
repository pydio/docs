---
slug: trigger-another-flow
title: "Trigger Another Flow"
menu: "Trigger Another Flow"
language: und
menu_name: menu-admin-guide-v6-enterprise
weight: 2

---

 Start another Job using its ID and optional parameters

### Parameters
|Label (internal name)|Type|Default|Description|
|---|---|---|---|
|**Flow Identifier** (jobID)|string|<no value>|Unique identifier (uuid) of the job to launch|
|**Pass Input to new Flow** (copyInput)|boolean|<no value>|Pass current Action input (Nodes, Users, etc...) as input to the new Flow|
|**Task Identifier (optional)** (taskID)|string|<no value>|If you need to know the task ID, otherwise generated automatically|
|**Name** (parameters.paramName)|string||Name of the parameter|
|**Value** (parameters.paramValue)|string||Value of the parameter|





