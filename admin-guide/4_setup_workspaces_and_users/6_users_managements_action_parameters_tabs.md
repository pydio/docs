---
slug: action-parameters
title: "Action parameters"
language: und
menu: "Action parameters"
weight: 5
menu_name: menu-admin-guide-v5

---

When you edit a group or a user, you are actually editing its underlaying role. Thus for the three of them (roles, groups, users), you will see the same tabs accessible : Common Info, ACLs, Actions and Parameters.

Go to your User/Group/Role edit it and go to **Application Parameters**

### Enabling Plugins / Disabling Plugins
Starting with Pydio 8, you can now fully enable/disable plugins for a specific role. This may be typically useful if you want to enable specific editors only for a subset of users, if these editors require third-party licensing.

In the parameters browser, look for "Enable " or for the name of the plugin to find the corresponding "Enable Plugin Name (pluginType.pluginId)" value.

![](../images/4_setup_workspaces_and_users/enable_editor_parameter.png)

### Overriding default parameters values
In the last tab of the role editor, “Parameters”, you will be able to set up a predefined value for any parameter of any plugin, using a multiple-step selector as for the actions disabler.

For example, let’s assume have two groups of users, one that has a Quota of 50M by default, and another group that should have a quota limit of 200M for their “My Files” workspace. You have already configured the default Quota value to 50M.

+ Edit the second group and under Parameters, select the plugin identified by  “meta.quota”
+ Then in the second selector switch to “DEFAULT_QUOTA” parameter
+ And in the third selector, select the “My Files” workspace.
+ Click on “Add parameter” and Save the group.

You should now see something like this :

![](../images/4_setup_workspaces_and_users/user_group_actions_disabled.png)
