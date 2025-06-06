---
slug: object-storage-drivers-s3-swift
title: "Object Storage drivers: S3, Swift"
language: und
menu: "Object Storage drivers: S3, Swift"
weight: 3
menu_name: menu-admin-guide-v5

---

# Cloud drivers : s3, hpcloud #

Naturally, with the high rise of the Object-Storage systems, particularly in the cloud, a couple of drivers may help you in getting access to this kind of storage. Currently access.s3 and access.hpcloud are the only ones available.

Disclaimer : If you installed Pydio by the linux repository ( apt / yum ), you must install the "pydio-plugin-access.s3" adn the "pydio-plugin-metastore.s3" package before.

The access.swift should be generalized to an open-stack Swift driver, as they are actually using this technology. It requires the PHP Swift Bindings.

The S3 driver uses the "Better AS3 Stream Wrapper" class to access the amazon Simple Storage System. You must configure the  API & SECRET KEYS, the REGION to query, the CONTAINER you want to browse and the API Version ( 2 or 3 ). Optionally, you can set the "Signature Version" of the API. Using this kind of storage driver is handy for cloud architectures, and more features should be developed around it. Worth noting, the "Metastore.S3" is a specific metadata storage implementation that goes along with this driver, using directly the S3 metadata system.

![](../../images/4_setup_workspaces_and_users/workspaces_object_storages.png)
