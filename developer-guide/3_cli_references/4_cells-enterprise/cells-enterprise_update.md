---
slug: cells-enterprise-update
title: "cells-enterprise update"
menu: "cells-enterprise update"
language: und
menu_name: menu-dev-guide-v7
weight: 61

---
Check for available updates and apply them

### Synopsis


DESCRIPTION

  List the available updates for the current binary.
  To apply the actual update, run the command with a --version parameter.


```
./cells-enterprise update [flags]
```

### Options

```
  -d, --dry-run          If set, this flag will grab the package and save it to the tmp directory instead of replacing current binary
  -h, --help             help for update
  -v, --version string   Pass a version number to apply the upgrade
```

### Options inherited from parent commands

```
      --config string   Configuration storage URL. Supported schemes: etcd|etcd+tls|file|grpc|mem|vault|vaults (default "file:///home/teamcity/.config/pydio/cells/pydio.json")
```

### SEE ALSO

* [./cells-enterprise](./cells-enterprise)	 - Secure File Sharing for business

