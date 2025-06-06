---
slug: install-from-archive
title: "Install from archive"
language: und
menu: "Install from archive"
weight: 1
menu_name: menu-admin-guide-v5

---

Download the latest stable version from Download Page either as ZIP or TAR.GZ format. Alternatively, you can use our Linux repositories to install Pydio using a package manager on Debian or CentOS Linux flavors.

Using your favorite FTP client or SCP command, upload this package to your webserver, and extract its content to a web-accessible folder (e.g. */var/www/pydio*).


Make sure the *data* path is writeable by the web server. For example :

> `chown -R www-data:www-data /var/www/pydio/data`


