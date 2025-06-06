---
slug: setup-webdav-server-access
title: "Setup WebDAV server access"
language: und
menu: "Setup WebDAV server access"
weight: 1
menu_name: menu-admin-guide-v5

---

### Command-line version of the framework
It’s possible to launch the whole framework and execute the actions via the command line. This has interesting consequences :

+ Launch “asynchronous” tasks from the GUI : they are started on the server and do not need to keep a window open
+ Launch some administrative tasks from outside the web, e.g. via a CRON job..
+ On Linux, if permissions allow it, it can be possible to stop a process.

This is already implemented in two new features, (see further), and should be generalized wherever possible!

+ Http Downloader : ability to trigger a remote file download asynchronously, without to have to keep a browser window open.
+ Zend Indexation : index the whole content of a workspace asynchronously.

If you want to play with the command line, placed at the root of the installation, you can simply call something like :

    php cmd.php -u=user -p=password -a=action -r=workspace_id --param1=value1 --param2=value2

Note the difference between **simple-dash** parameters and **double-dash** parameters : the latter ones are the parameters passed to the required “action”.

When launched from the web framework, an encrypted token is passed instead of the password.
