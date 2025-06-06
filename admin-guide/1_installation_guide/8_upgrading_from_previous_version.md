---
slug: upgrading-from-previous-version
title: "Upgrading from previous version"
language: und
menu: "Upgrading from previous version"
weight: 8
menu_name: menu-admin-guide-v5

---

## In-App upgrade from Pydio 6

Upgrade is automatic from within the app for archive-based installs (zip / tar.gz). Make sure to backup the database and the files.

![](../images/1_installation_guide/getting_started_update_plugin_parameters.png)

For update to v6 from stable version 5.2.5, please be sure that you have configured action.updater as following capture:

![](../images/1_installation_guide/getting_started_update_dialog.png)

After saving the modification, click on upgrade button on top right bar, you can see this dialog.

![](../images/1_installation_guide/getting_started_after_upgrade.png)

Click on Start Upgrade on dialog

If there is no error reported, You can logout, refresh the page login again and experience new version

## Upgrading from Pydio 6 when installed via apt/yum

If Pydio is installed via a package manager, you can use the in-app upgrade processus. You first have to update the packages, using yum / apt-get commands, then manually apply the followings steps:
 
 - Update database
 - Check /etc/bootstrap_*.php are up-to-date
 - Update share.php

## Upgrading from previous versions

Please read the upgrade instructions of v6 documentation.