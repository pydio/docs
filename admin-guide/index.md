---
title: admin-guide
weight: 0
---


* **[Quick Start](.././quick-start/index/)**
  * [Requirements](../quick-start/requirements)
  * **[Cells Installation](../quick-start/cells-installation/index/)**
    * [Install Static Binaries](../quick-start/cells-installation/install-static-binaries)
    * [Docker](../quick-start/cells-installation/docker)
    * [Open Virtual Format](../quick-start/cells-installation/open-virtual-format)
    * [VMWare](../quick-start/cells-installation/vmware)
    * [Amazon AMI](../quick-start/cells-installation/amazon-ami)
  * [Quick Admin Tour](../quick-start/quick-admin-tour)
  * [Sharing Features](../quick-start/sharing-features)
  * **[Add Collaboration Tools](../quick-start/add-collaboration-tools/index/)**
    * ['[Ent] Only Office'](../quick-start/add-collaboration-tools/ent-only-office)
    * [Collabora Online](../quick-start/add-collaboration-tools/collabora-online)
  * [Connect Desktop Sync](../quick-start/connect-desktop-sync)
  * [Mobile Apps](../quick-start/mobile-apps)
  * [Glossary](../quick-start/glossary)
* **[Run Cells in Production](.././run-cells-in-production/index/)**
  * **[Best practices](../run-cells-in-production/best-practices/index/)**
    * [Recommended Architectures](../run-cells-in-production/best-practices/recommended-architectures)
    * [Create a Dedicated MySQL User](../run-cells-in-production/best-practices/create-a-dedicated-mysql-user)
    * [Create a Service User](../run-cells-in-production/best-practices/create-a-service-user)
    * [Linux Service](../run-cells-in-production/best-practices/linux-service)
    * [Working Directories](../run-cells-in-production/best-practices/working-directories)
    * [System Logs](../run-cells-in-production/best-practices/system-logs)
  * **[Configuring Cells URLs](../run-cells-in-production/configuring-cells-urls/index/)**
    * [Manage Sites](../run-cells-in-production/configuring-cells-urls/manage-sites)
    * [Configure Cells with a reverse-proxy](../run-cells-in-production/configuring-cells-urls/configure-cells-with-a-reverse-proxy)
    * [Configure TLS](../run-cells-in-production/configuring-cells-urls/configure-tls)
  * [Configuring Mongo Storage](../run-cells-in-production/configuring-mongo-storage)
  * [Configuring Email Delivery](../run-cells-in-production/configuring-email-delivery)
  * **[Upgrades](../run-cells-in-production/upgrades/index/)**
    * [Software Upgrades](../run-cells-in-production/upgrades/software-upgrades)
    * [Major Versions Upgrade Informations](../run-cells-in-production/upgrades/major-versions-upgrade-informations)
  * **[Operational Maintenance](../run-cells-in-production/operational-maintenance/index/)**
    * [Truncate Logs / Audits](../run-cells-in-production/operational-maintenance/truncate-logs-audits)
    * [Purge Activities / Notifications](../run-cells-in-production/operational-maintenance/purge-activities-notifications)
    * [Monitoring Tools](../run-cells-in-production/operational-maintenance/monitoring-tools)
    * [Backup / Recover](../run-cells-in-production/operational-maintenance/backup-recover)
  * **[Deploying Cells in a Distributed Environment](../run-cells-in-production/deploying-cells-in-a-distributed-environment/index/)**
    * [Kubernetes Quick install](../run-cells-in-production/deploying-cells-in-a-distributed-environment/kubernetes-quick-install)
    * [Going Stateless](../run-cells-in-production/deploying-cells-in-a-distributed-environment/going-stateless)
    * [External Services](../run-cells-in-production/deploying-cells-in-a-distributed-environment/external-services)
    * [Configuring with URLs](../run-cells-in-production/deploying-cells-in-a-distributed-environment/configuring-with-urls)
    * [Deploying Cells Nodes](../run-cells-in-production/deploying-cells-in-a-distributed-environment/deploying-cells-nodes)
    * [Migrating from Single Node](../run-cells-in-production/deploying-cells-in-a-distributed-environment/migrating-from-single-node)
    * [K8s Advanced Parameters](../run-cells-in-production/deploying-cells-in-a-distributed-environment/k8s-advanced-parameters)
    * [Providing HA with Docker Compose](../run-cells-in-production/deploying-cells-in-a-distributed-environment/providing-ha-with-docker-compose)
  * [Troubleshooting](../run-cells-in-production/troubleshooting)
* **[Connect your users](.././connect-your-users/index/)**
  * [Manage Users](../connect-your-users/manage-users)
  * **[Single-Sign-On Features](../connect-your-users/single-sign-on-features/index/)**
    * [Cells as Identity Provider](../connect-your-users/single-sign-on-features/cells-as-identity-provider)
    * ['[Ent] Using SSO with an External Identity Provider'](../connect-your-users/single-sign-on-features/ent-using-sso-with-an-external-identity-provider)
    * ['[Ent] LDAP / AD'](../connect-your-users/single-sign-on-features/ent-ldap-ad)
    * ['[Ent] LDAP / AD (Advanced)'](../connect-your-users/single-sign-on-features/ent-ldap-ad-advanced)
    * ['[Ent] AD + Kerberos Support'](../connect-your-users/single-sign-on-features/ent-ad-kerberos-support)
  * [Users / Teams Visibility](../connect-your-users/users-teams-visibility)
  * ['[Ent] Group Tenancy'](../connect-your-users/ent-group-tenancy)
  * ['[Ent] Admin Delegation'](../connect-your-users/ent-admin-delegation)
  * **[Additional APIs](../connect-your-users/additional-apis/index/)**
    * [Webdav Server Access](../connect-your-users/additional-apis/webdav-server-access)
    * ['[Ent] SFTP Access'](../connect-your-users/additional-apis/ent-sftp-access)
    * [Personal Access Tokens](../connect-your-users/additional-apis/personal-access-tokens)
* **[Connect your Storage](.././connect-your-storage/index/)**
  * [Datasources overview](../connect-your-storage/datasources-overview)
  * **[Datasource Format](../connect-your-storage/datasource-format/index/)**
    * [Structured Storage - Best for accessing the files directly](../connect-your-storage/datasource-format/structured-storage-best-for-accessing-the-files-directly)
    * [Flat Storage - Best for performances](../connect-your-storage/datasource-format/flat-storage-best-for-performances)
    * [Recovering a Flat Storage Datasource with Cells Fuse](../connect-your-storage/datasource-format/recovering-a-flat-storage-datasource-with-cells-fuse)
    * [Switching Datasource Storage Formats](../connect-your-storage/datasource-format/switching-datasource-storage-formats)
  * **[Create datasources](../connect-your-storage/create-datasources/index/)**
    * [Common Options](../connect-your-storage/create-datasources/common-options)
    * [File System Storage](../connect-your-storage/create-datasources/file-system-storage)
    * [Mounts / NAS](../connect-your-storage/create-datasources/mounts-nas)
    * [S3 Compatible Storage](../connect-your-storage/create-datasources/s3-compatible-storage)
    * ['[Ent] Google Cloud Storage'](../connect-your-storage/create-datasources/ent-google-cloud-storage)
    * ['[Ent] Azure Blob Storage'](../connect-your-storage/create-datasources/ent-azure-blob-storage)
  * [Versioning Policies](../connect-your-storage/versioning-policies)
  * [Encryption](../connect-your-storage/encryption)
  * [Metadata](../connect-your-storage/metadata)
  * ['[Ent] Enable image and video annotations'](../connect-your-storage/ent-enable-image-and-video-annotations)
  * ['[Ent] Assign quotas'](../connect-your-storage/ent-assign-quotas)
  * ['[Ent] Shard with template path'](../connect-your-storage/ent-shard-with-template-path)
* **[Secure your data](.././secure-your-data/index/)**
  * [Workspaces / Cells](../secure-your-data/workspaces-cells)
  * [Role-based Access Control](../secure-your-data/role-based-access-control)
  * **['[Ent] Dynamic Access Control'](../secure-your-data/ent-dynamic-access-control/index/)**
    * [Using Security Policies](../secure-your-data/ent-dynamic-access-control/using-security-policies)
    * [Rules Conditions](../secure-your-data/ent-dynamic-access-control/rules-conditions)
  * **['[Ent] Hardening Security'](../secure-your-data/ent-hardening-security/index/)**
    * ['[Ent] Password Complexity'](../secure-your-data/ent-hardening-security/ent-password-complexity)
    * ['[Ent] Multi factor authentication'](../secure-your-data/ent-hardening-security/ent-multi-factor-authentication)
    * ['[Ent] IP Ban'](../secure-your-data/ent-hardening-security/ent-ip-ban)
  * **['[Ent] Audits & Compliance'](../secure-your-data/ent-audits-compliance/index/)**
    * ['[Ent] Viewing and Exporting Audit Logs'](../secure-your-data/ent-audits-compliance/ent-viewing-and-exporting-audit-logs)
    * ['[Ent] Visualize Shared Resources'](../secure-your-data/ent-audits-compliance/ent-visualize-shared-resources)
    * ['[Ent] Explore Storage Usage'](../secure-your-data/ent-audits-compliance/ent-explore-storage-usage)
    * ['[Ent] Adding Terms of Service'](../secure-your-data/ent-audits-compliance/ent-adding-terms-of-service)
  * [UX Actions / Parameters](../secure-your-data/ux-actions-parameters)
* **[Customize interface](.././customize-interface/index/)**
  * ['[Ent] Logos and Wording'](../customize-interface/ent-logos-and-wording)
  * ['[Ent] Brand Theme'](../customize-interface/ent-brand-theme)
  * ['[Ent] Email Templates'](../customize-interface/ent-email-templates)
  * ['[Ent] EasyTransfer Layout'](../customize-interface/ent-easytransfer-layout)
  * ['[Ent] Using SmartForm'](../customize-interface/ent-using-smartform)
* **[Advanced](.././advanced/index/)**
  * [Migrate Pydio 8 to Cells](../advanced/migrate-pydio-8-to-cells)
  * [Scheduler / Cells Flows](../advanced/scheduler-cells-flows)
  * [YAML/JSON Installation](../advanced/yaml-json-installation)
  * [Pydio Cells Internals](../advanced/pydio-cells-internals)
  * [Advanced configurations](../advanced/advanced-configurations)
