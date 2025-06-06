---
slug: flows-versioning
title: "Flows Versioning"
language: und
menu: "Flows Versioning"
weight: 3
description: "This page describe how Flows are versioned and how you can create or restore a specific revision of a Flow."
menu_name: menu-admin-guide-v6-enterprise

---
Flows modifications can be destructive and often you want to restore a previous version of a Flow. This section describes Flows versioning feature.

### Restoring an auto-saved version

Each time you save a Flow, the previous version is copied as a backup, in case you inadvertently broke something. You can list and restore available version by clicking on the bottom-right button. 

![](../../images/0_overview/jobs-versioning-auto-saved.png)

Select the version you wish to restore

### Tagging your own versions

Cells Flows only "auto-save" one version by default to avoid storing too much data and having to deploy complex versioning strategies. Once you have a satisfactory Flow, you can "Tag" it and create a version that will be kept. That way, you can make sure that you will be able to restore it anytime in the future.

The versions dialogs shows the list of all versions.

![](../../images/0_overview/jobs-versioning-custom-tagged-version.png)