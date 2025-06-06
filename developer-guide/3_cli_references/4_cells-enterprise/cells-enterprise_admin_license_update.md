---
slug: cells-enterprise-admin-license-update
title: "cells-enterprise admin license update"
menu: "cells-enterprise admin license update"
language: und
menu_name: menu-dev-guide-v7
weight: 45

---
Update enterprise license

### Synopsis


DESCRIPTION

  This command allows you to update Cells Enterprise license key



```
./cells-enterprise admin license update [flags]
```

### Options

```
  -h, --help   help for update
```

### Options inherited from parent commands

```
      --advertise_address string     Default advertise address (default "127.0.0.1")
      --broker string                Pub/sub service for events between services (default "grpc://:8030")
      --config string                Configuration storage URL. Supported schemes: etcd|etcd+tls|file|grpc|mem|vault|vaults (default "file:///home/teamcity/.config/pydio/cells/pydio.json")
      --discovery string             Registry and pub/sub (default "grpc://:8030")
      --grpc_client_timeout string   Default timeout for long-running GRPC calls, expressed as a golang duration (default "60m")
      --registry string              Registry used to contact services (default "grpc://:8030")
```

### SEE ALSO

* [./cells-enterprise admin license](../cells-enterprise-admin-license)	 - Manage Cells Enterprise license

