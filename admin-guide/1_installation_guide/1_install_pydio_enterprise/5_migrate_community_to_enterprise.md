---
slug: in-app-migration-from-community-to-enterprise
title: "In-app Migration from Community to Enterprise"
language: und
menu: "[ED] From existing community edition"
weight: 5
menu_name: menu-admin-guide-v5

---

Pydio in-app upgrade tool allows you to directly migrate from an existing Community Edition installation to Pydio Enterprise Distribution. The steps are described below.

### Prepare for migration

There are some differences for running Pydio Enterprise Distribution (ED) compared to our core community package. Based on an End User License Agreement, some files of the ED are encrypted and require a license key to be used. 

- **IonCube Loaders:** Install on your server the php IonCube Loaders provided by IonCube on their server and the PHP version. Their wizard provides you an easy way to install the loaders.
- **License Key:** Once installed, the ED will require a license name/license key pair that is available in your Pydio.com account once you have bought them to our sales services.
- **API Keys:** In order to connect to our protect packages repositories, you will need the API Keys provided in your pydio.com. These are NOT the same as the license name/license key pair.

### Set up upgrade channel

Go to **Menu > Logs & Other data > Upgrade ** :

- Change the update site to https://update.pydio.com/auth/
- Update the target channel to "Install Enterprise Distribution" : this will be for the migration only, after the operation make sure to switch back to **"Stable"** channel.
- In the Authenticated Update Site section, copy and paste the API Keys you took from your account. 

![](../../images/1_installation_guide/migration/migrate_01_update_site.png)

Once you have saved the modification of the upgrade engine, click on "CHECK NOW". You should see a new package ready for installation: pydio-enterprise-migration-8.0.0.zip. If you have a connection error, like a '401 not authorized', make sure you correctly copied the API keys and try again.

![](../../images/1_installation_guide/migration/migrate_02_update_available.png)

### Apply upgrade

You may now select the package, and apply upgrade.

![](../../images/1_installation_guide/migration/migrate_03_select_package.png)

If everything goes well, you should see a welcome screen in the upgrade panel:

![](../../images/1_installation_guide/migration/migrate_04_welcome.png)

### Set up license information

If you now reload the page fully, you should see an error message warning about the invalid license. Don't panic, this is normal. 

![](../../images/1_installation_guide/migration/migrate_05_invalid_license.png)

In the left column menu, go to the newly appeared "Enterprise License" section, and there enter your License Name / License String in the form, then save. If you have some weird displays, please manually clear the caches of the application by connecting to your server and running the following command in your pydio installation folder, then reload.

    rm data/cache/plugins_*.*
    rm data/cache/i18n/*.*

![](../../images/1_installation_guide/migration/migrate_06_setup_license.png)

Once the license is detected as valid, the panel should show the license information (number of users, expiration date)

![](../../images/1_installation_guide/migration/migrate_07_license_valid.png)

### You're done!

Reloading the page, you should now have access to the new Enterprise Dashboard and the whole set of professional features provided by this distribution! 

![](../../images/1_installation_guide/migration/migrate_08_finished.png)