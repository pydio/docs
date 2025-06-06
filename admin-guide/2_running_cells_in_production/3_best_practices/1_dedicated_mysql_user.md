---
slug: create-a-dedicated-mysql-user
title: Create a Dedicated MySQL User
description: Setting up a dedicated MySQL user for a Pydio Cells instance.
menu: Dedicated MySQL User
language: und
weight: 1
menu_name: menu-admin-guide-v7-enterprise

---
By default, a new database will be created by the system during the installation process. You only need a user with database management permissions.

If you would rather do it manually, you may create a dedicated user and an empty database by executing the following SQL queries :

```SQL
CREATE USER 'pydio'@'localhost' IDENTIFIED BY '<your-password-here>';
CREATE DATABASE cells;
GRANT ALL PRIVILEGES ON cells.* to 'pydio'@'localhost';
FLUSH PRIVILEGES;
```