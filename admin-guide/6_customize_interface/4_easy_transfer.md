---
slug: ent-easytransfer-layout
title: '[Ent] EasyTransfer Layout'
description: 'How to create a seamless upload-and-share experience for users.'
menu: '[Ent] EasyTransfer Layout'
language: und
weight: 4
menu_name: menu-admin-guide-v7-enterprise

---
Sometimes for inexperimented users, it is better to provide a limited UX with less options and automated actions. Cells Enterprise EasyTransfer layout can be applied on any workspace to provide an all-in-one "Upload and Share" experience to users.

## Activating EasyTransfer

When editing a workspace (as admin), you can select the EasyTransfer layout at the bottom of the form. 

![](../images/6_customize_interface/ez-setup.png)

After saving, when a user will open this workspace, she will be presented the following "drop file" interface. 

![](../images/6_customize_interface/ez-ux.png)

Each time a file is dropped, it is automatically shared as a public link, and the link is displayed to the user with the ability to send this link by email. 

![](../images/6_customize_interface/ez-shared.png)

Simple! 

## Recommended Setup

As the user cannot actually see the content that has been already previously uploaded, this layout can be applied to a shared workspace. However, as the target is generally an over-simplification of the UX, we recommend the following setup for the target users (either by editing the Root Group role or by defining a specific role for specific users).

- Use EasyTransfer layout on the **Personal Files**
- Via a role, DENY accesses to any workspaces except for R/W on Personal Files
- In the role as well, DENY access also the "Welcome" home page (under Application Pages)

![](../images/6_customize_interface/ez-rights.png)

That way, a user will be immediately directed to the file-drop interface after login.