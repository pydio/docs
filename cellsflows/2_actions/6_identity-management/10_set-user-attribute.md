---
slug: set-user-attribute
title: "Set user attribute"
menu: "Set user attribute"
language: und
menu_name: menu-admin-guide-v6-enterprise
weight: 10

---

 Add arbitrary attribute on input users (to be chained with a Persist Identity action). Lease value empty for clear attribute, or use +/- symbols if attribute handles multiple values.

### Parameters
|Label (internal name)|Type|Default|Description|
|---|---|---|---|
|**Attribute Name** (attributeName)|string|<no value>|Name of the attribute, can use template|
|**Attribute Value** (attributeValue)|string|<no value>|Value to set (can use templates). Leave empty to delete attribute|
|**Multiple values** (attributeMultiple)|boolean|<no value>|If attribute is expected to support multiple values (like locks), use leading + or - in value|



### Expected Input
Users


### Expected Input
Users


