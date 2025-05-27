---
slug: writing-a-plugin
title: "Writing a plugin"
language: und
menu: "Writing a plugin"
weight: 3
menu_name: menu-developer-guide
description: "Write your first plugin by following an example."

---

In this section, you will "learn-by-example" how to create your own Pydio plugin to extend the software functionnalities. This can go from adding a simple HTML block on the interface to adding your own API's to Pydio. 

If you want a better understanding of what you do, you can first read the "GOING DEEPER" chapter to grab Pydio's internals. However, it should not be necessary for this tutorial.

The manifest.xml file is a central piece of each plugin. Its grammar is entirely described in the **plugins/core.ajaxplorer/ajxp_registry.xsd** XML Schema, thus it is very recommanded to use an XML editor supporting schemas. The tags and elements should be generally self explaining, and we try to document the schema, but here we will go through some specifc elements that are part of the day-to-day life of a plugin developer.

- [Action.skeleton plugin](/pydio-v8/developer-guide/writing-a-plugin/action-skeleton-plugin/)
- [Contributing actions](/pydio-v8/developer-guide/writing-a-plugin/contributing-actions/)
- [Declaring resources](/pydio-v8/developer-guide/writing-a-plugin/declaring-resources/)
- [Manifest.xml overview](/pydio-v8/developer-guide/writing-a-plugin/manifest-xml-overview/)
- [Modify the GUI](/pydio-v8/developer-guide/writing-a-plugin/modify-the-gui/)
