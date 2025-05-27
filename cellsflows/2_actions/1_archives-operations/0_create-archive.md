---
slug: create-archive
title: "Create Archive"
menu: "Create Archive"
language: und
menu_name: menu-admin-guide-v6-enterprise
weight: 0

---

 Create a Zip, Tar or Tar.gz archive from the input

### Parameters
|Label (internal name)|Type|Default|Description|
|---|---|---|---|
|**Archive path** (target)|string|<no value>|FullPath to the new archive|
|**Archive format** (format)|select, possible values: Detect (file extension) (detect),<br/>Zip (zip),<br/>Tar (tar),<br/>TarGz (tar.gz)|detect|Compression format of the archive|



### Expected Input
Selection of node(s). Folders will be recursively walked through.


### Expected Input
One single node pointing to the created archive file.


