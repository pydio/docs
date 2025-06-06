---
slug: user-data-clean-up
title: "User-data clean up"
menu: "User-data clean up"
language: und
menu_name: menu-admin-guide-v6-enterprise
weight: 7

---

[Internal] Clean user data on deletion. Personal resources are moved to folder suffixed with the user UUID.

### Parameters
|Label (internal name)|Type|Default|Description|
|---|---|---|---|
|**Data copy destination** (targetParent)|string|<no value>|Where to copy or move original files (sibling folder by default)|



### Expected Input
Single-selection of one user, provided by the delete user event.



