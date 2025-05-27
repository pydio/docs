---
slug: internal-data-model
title: "Internal Data Model"
language: und
menu: "Internal Data Model"
weight: 3
menu_name: menu-developer-guide
description: "This section describes how the pydio internal data (authentication, configurations) are managed"

---

## Data Model
By Pydio internal data, we refer to all “configuration” data that are not the files and folders stored in the workspaces. These data cover workspaces definitions, users, roles, etc… The following schema describes the datamodel.

![](../images/global_architecture/internal_data_model/pydio-datamodel-new.png)
 
## Accessing this Data
As you might already have understood, most of these objects can be stored in various backends, depending on the chosen plugin. For the most commonly used (workspaces & users/roles data), there are two static classes that you must know: AuthService and ConfService. These classes will hide the actual plugin implemenation and provide simple to use APIs to CRUD the various objects.
