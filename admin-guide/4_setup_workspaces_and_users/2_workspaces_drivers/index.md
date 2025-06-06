
As explained in the Introduction to Workspaces, workspace is defined by two things : the "driver" used to access the data (local filesystem, remote ftp server, database, etc...), and the configuration of this driver (the local path to the files, the database credentials, etc). You can even develop your own access driver by following the plugin api. The full list of available drivers for accessing the data is in the "Plugins" part of this documentation, above the "access" category : **https://pydio.com/docs/references/plugins/access/**

To create a workspace, go on your **"Menu" > "Workspaces & Users" > "Workspaces"** in click on **+Workspace** (top of page) and fill the dialog window : use a short, unique and understandable label, and choose the driver that will be used for this workspace. If you don't have an idea of what a driver is, simply choose the "File System (Standard)" driver. Then, depending on the chosen driver, some parameters will appear. All parameters followed by a star "\*" are mandatory. Consult also the "access" plugin documentation on the website. Once your configuration is ok, save the workspace. The workspaces list (left of your screen) should be automatically updated, and you can switch to the new workspace to see if everything is alright (by default, admin user has read/write to all repositories, even newly created).

The following chapter will go through the main drivers available.

- [Most standard case: FS driver](../most-standard-case-fs-driver/)
- [Accessing remote servers: ftp, sftp, smb, webdav, dropbox](../accessing-remote-servers-ftp-sftp-smb-webdav-dropbox/)
- [Access.fs + Meta.mount](../access-fs-meta-mount/)
- [Object Storage drivers: S3, Swift](../object-storage-drivers-s3-swift/)
- [Non-files drivers: mysql, imap, ajxp_*, jsapi](../non-files-drivers-mysql-imap-ajxp-jsapi/)
