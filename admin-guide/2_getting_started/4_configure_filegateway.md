---
slug: file-gateway
title: "File Gateway"
language: und
menu: "Set up File Gateway"
weight: 4
menu_name: menu-admin-guide-v5

---

## What is File Gateway ? 

File Gateway is a unique service proposed by Pydio to help you secure your installation. When you share a public link with an external person, it will "by design" send to the outside world the base URL of your Pydio installation, like https://yourdomain.tld/pydio/public/{unique_hash}. 

To avoid disclosing this base URL (https://yourdomain.tld/pydio/), File Gateway is a hosted proxy that will transform the public link into https://filesend.cc/{another_unique_hash}. People accessing this link will never see your base URL.

## Setup File Gateway

As a hosted service, File Gateway is a paying feature. If you are interested, please contact our Sales service and once you have a valid subscription for this, you will need your API Key as featured in your Pydio.com account.

![](../images/1_installation_guide/install_pydio_api_keys.png)

Open the Settings panel of your pydio and under go to **All Plugins > URL Shortening** , look for the "File Gateway" link shortener plugin. Enable the plugin and put your API Key / API Secret in the configuration ( click on the pen located on the right of the plugin's line). Pick the domain and region on which you want your link to be hosted. We currently propose 2 different domains (filesend.cc, yoursha.re), and each of them can be hosted in either United States or Europe. Choose the region closest to your installation and your most common users. 

![](../images/2_getting_started/filegateway_enterprise.png)

## Checking Setup

Once it is activated, the usage is transparent for your users. As soon as you generate a public link, you should see that the links are now generated with this remote URL instead of your pydio URL.

![](../images/2_getting_started/file_gateway_share.png)
