---
slug: advanced-setups
title: Advanced setups
description: Deploying Pydio Cells Enterprise in various environments.
menu: 'Advanced setups'
language: und
weight: 6

---
### Advanced step-by-step guides

These tutorials provide advanced step-by-step guides for bare installation on your OS/Cloud of choice, from RaspberryPi to Kubernetes Cluster!

=== "[<img src="../../../images/logos-os/logo-raspberrypi.png" width="60" >]()"
    _This guide explains how to install and configure Cells on a Raspberry Pi system_.

    **Use case**

    Deploy a self-contained Pydio Cells instance on your local home network with a simple Raspberry Pi.

    **Requirements**

    - Although we tested and could start Cells on a Rasberry Pi 3B with only 1GB of RAM, we suggest to use a version 4B with at least 4 GB RAM.
    - **Storage**: 32 SD card
    - **Operating System**:
    - Raspbian (Bullseye, Buster or Stretch), the official Raspberry Pi desktop OS (which a Raspbian repackaged the Raspberry Pi team) also works out of the box.  
    - An admin user with sudo rights that can connect to the server via SSH
    - **Networking**: TODO.

    ## Installation

    ### Dedicated user and file system layout

    We recommend to run Pydio Cells with a dedicated `pydio` user with **no sudo** permission:

    ```sh
    # Create pydio user with a home directory
    sudo useradd -m -s /bin/bash pydio

    # Create necessary folders
    sudo mkdir -p /opt/pydio/bin /var/cells/certs
    sudo chown -R pydio: /opt/pydio /var/cells

    # Add system-wide ENV var
    sudo tee -a /etc/profile.d/cells-env.sh << EOF
    export CELLS_WORKING_DIR=/var/cells
    EOF
    sudo chmod 0755 /etc/profile.d/cells-env.sh
    ```

    #### Verification

    Login as user `pydio` and make sure that the environment variables are correctly set:

    ```sh
    user@raspberrypi:~$ sudo su - pydio 
    pydio@raspberrypi:~$ echo $CELLS_WORKING_DIR
    /var/cells
    pydio@raspberrypi:~$ exit
    ```

    ### Database

    We use the default mariadb-server package shipped with Bullseye, it installs the 10.5 version with no hassle:

    ```sh
    sudo apt install mariadb-server
    # You should run the script to secure your install
    sudo mysql_secure_installation

    # Open MySQL CLI to create your database and a dedicated user
    sudo mysql -u root -p
    ```

    Start a MySQL prompt and create the database and the dedicated `pydio` user.

    ```mysql
    CREATE DATABASE cells;
    CREATE USER 'pydio'@'localhost' IDENTIFIED BY '<PUT YOUR PASSWORD HERE>';
    GRANT ALL PRIVILEGES ON cells.* to 'pydio'@'localhost';
    FLUSH PRIVILEGES;
    exit
    ```

    #### Verification

    Check the service is running and that the user `pydio` is correctly created:

    ```sh
    sudo systemctl status mariadb
    mysql -u pydio -p
    ```

    ### Retrieve binary

    Note: we only started shipping the necessary ARM build for Cells at v4.

    ```sh
    # As pydio user
    sudo su - pydio 

    # Download correct binary
    distribId=cells 
    # or for Cells Enterprise
    # distribId=cells-enterprise 
    wget -O /opt/pydio/bin/cells https://download.pydio.com/latest/${distribId}/release/{latest}/linux-arm/${distribId}

    # Make it executable
    chmod a+x /opt/pydio/bin/cells
    exit

    # As sysadmin user 
    # Add permissions to bind to default HTTP ports
    sudo setcap 'cap_net_bind_service=+ep' /opt/pydio/bin/cells

    # Declare the cells commands system wide
    sudo ln -s /opt/pydio/bin/cells /usr/local/bin/cells
    ```

    #### Verification

    Call the command `version` as user `pydio`:

    ```sh
    sudo su - pydio 
    cells version
    ```

    ## Configuration

    ### Configure the server

    Call the command `configure` as user `pydio`:

    ```sh
    sudo su - pydio 
    cells configure
    ```

    If you choose `Browser install` at the first prompt, you can access the configuration wizard at `https://<YOUR PUBLIC IP>:8080` after accepting the self-signed certificate. (Ensure the port `8080` is free and not blocked by a firewall).

    You can alternatively finalise the configuration from the command line by answering a few questions.

    #### Verification

    If you used the browser install, you can login in the web browser as user `admin`.

    If you have done the CLI install, you first need to start the server:

    ```sh
    sudo su - pydio 
    cells start
    ```

    Connect and login at `https://<YOUR PUBLIC IP>:8080`

    **Note**:  
    At this stage, we start the server in **foreground** mode. In such case, it is important that you **always stop** the server using the `CTRL + C` shortcut before calling the `start` command again.

    ## Finalisation

    ### Run your server as a service with systemd

    Create a configuration file `sudo vi /etc/systemd/system/cells.service` with the following:

    ```conf
    [Unit]
    Description=Pydio Cells
    Documentation=https://pydio.com
    Wants=network-online.target
    After=network-online.target
    AssertFileIsExecutable=/opt/pydio/bin/cells

    [Service]
    User=pydio
    Group=pydio
    PermissionsStartOnly=true
    AmbientCapabilities=CAP_NET_BIND_SERVICE
    ExecStart=/opt/pydio/bin/cells start
    Restart=on-failure
    StandardOutput=journal
    StandardError=inherit
    LimitNOFILE=65536
    TimeoutStopSec=5
    KillSignal=INT
    SendSIGKILL=yes
    SuccessExitStatus=0
    WorkingDirectory=/home/pydio

    # Add environment variables
    Environment=CELLS_WORKING_DIR=/var/cells

    [Install]
    WantedBy=multi-user.target
    ```

    Reload systemd daemon, enable and start cells:

    ```sh
    sudo systemctl daemon-reload
    sudo systemctl enable --now cells
    ```

    #### Verification

    ```sh
    # you can check the system logs to insure everything seems OK
    journalctl -fu cells -S -1h
    ```

    **You are now good to go**. Happy file sharing!

    ## Troubleshooting

    ### Main tips

    With cells as a service, you can access the logs in different ways:

    ```sh
    # Pydio file logs
    tail -200f /var/cells/logs/pydio.log
    # Some of the microservices have their own log files, check:
    ls -lsah /var/cells/logs/

    # Check systemd files
    journalctl -fu cells -S -1h
    ```

=== "[<img src="../../../images/logos-os/logo-rhel.png" width="60" >]()"
    _This guide explains how to configure Cells on a Red-Hat-Enterprise-Linux-like system. It contains strongly opinionated choices and best practices. It guides you through the steps required for a production-ready and reasonnably secured server. For a simple test on a RHEL-like server, you can skim through [our quick start page](./quick-start) instead_.

    **Usecase**

    Deploy a self-contained Pydio Cells instance on a web-facing RHEL-like Linux server,  
    exposed at `https://<your-fqdn>` using a Let's Encrypt certificate.

    **Requirements**

    - **CPU/Memory**: 4GB RAM, 2 CPU
    - **Storage**: 100GB SSD hard drive
    - **Operating System**:
    - RHEL 7, 8 or 9, Rocky Linux 8 or 9, CentOS and Scientific Linux 7.  
    - An admin user with sudo rights that can connect to the server via SSH
    - _Note: The present guide uses a Rocky Linux 9 server. You might have to adapt some commands if you use a different version or flavour._
    - **Networking**:
    - One Network Interface Controller connected to the internet
    - A registered domain that points toward the public IP of your server: if you already know your IP address, it is a good idea to already add a `A Record` in your provider DNS so that the record has been already propagated when we need it.

    ## Installation

    ### Dedicated user and file system layout

    We recommend to run Pydio Cells with a dedicated `pydio` user with **no sudo** permission.

    As admin user on your server:

    ```sh
    # Create pydio user with a home directory
    sudo useradd -m -s /bin/bash pydio

    # Create necessary folders
    sudo mkdir -p /opt/pydio/bin /var/cells/certs
    sudo chown -R pydio:pydio /opt/pydio /var/cells

    # Add system-wide ENV var
    sudo tee -a /etc/profile.d/cells-env.sh << EOF
    export CELLS_WORKING_DIR=/var/cells
    EOF
    sudo chmod 0755 /etc/profile.d/cells-env.sh
    ```
    #### Verification

    Login as user `pydio` and make sure that the environment variables are correctly set:

    ```sh
    sysadmin@server:~$ sudo su - pydio 
    pydio@server:~$ echo $CELLS_WORKING_DIR
    /var/cells
    pydio@server:~$ exit
    ```

    ### Database

    On Rocky Linux 9.2, default MariaDB package is 10.5 that works well for Cells. So simply do:

    ```sh
    sudo yum install mariadb-server
    sudo systemctl enable --now mariadb

    # Run the script to secure your install
    sudo mysql_secure_installation

    # Open MySQL CLI to create your database and a dedicated user
    sudo mysql -u root -p
    ```

    Start a MySQL prompt and create the database and the dedicated `pydio` user.

    ```mysql
    CREATE DATABASE cells;
    CREATE USER 'pydio'@'localhost' IDENTIFIED BY '<PUT YOUR OWN PASSWORD HERE>';
    GRANT ALL PRIVILEGES ON cells.* to 'pydio'@'localhost';
    FLUSH PRIVILEGES;
    exit
    ```

    #### Verification

    Check the service is running and that the user `pydio` is correctly created:

    ```sh
    sudo systemctl status mariadb
    mysql -u pydio -p
    ```

    ### Retrieve binary

    ```sh
    # As pydio user
    sudo su - pydio 

    # Download correct binary
    distribId=cells 
    # or for Cells Enterprise
    # distribId=cells-enterprise 
    wget -O /opt/pydio/bin/cells -v https://download.pydio.com/latest/${distribId}/release/{latest}/linux-amd64/${distribId}

    # Make it executable
    chmod a+x /opt/pydio/bin/cells
    exit

    # As sysadmin user 
    # Add permissions to bind to default HTTP ports
    sudo setcap 'cap_net_bind_service=+ep' /opt/pydio/bin/cells

    # Declare the cells commands system wide
    sudo ln -s /opt/pydio/bin/cells /usr/local/bin/cells
    ```

    #### Verification

    Call the command `version` as user `pydio`:

    ```sh
    sudo su - pydio 
    cells version
    ```

    ## Configuration

    ### Configure the server

    Call the command `configure` as user `pydio`:

    ```sh
    sudo su - pydio 
    cells configure
    ```

    If you choose `Browser install` at the first prompt, you can access the configuration wizard at `https://<YOUR PUBLIC IP>:8080` after accepting the self-signed certificate. (Ensure the port `8080` is free and not blocked by a firewall).

    You can alternatively finalise the configuration from the command line by answering a few questions.

    #### Verification

    If you used the browser install, you can login in the web browser as user `admin`

    First insure your firewall does not block the port 8080:

    ```sh
    sudo firewall-cmd --add-port=8080/tcp
    ```

    If you have done the CLI install, you first need to start the server:

    ```sh
    sudo su - pydio 
    cells start
    ```

    Connect and login at `https://<YOUR PUBLIC IP>:8080`

    **Note**:  
    At this stage, we start the server in **foreground** mode. It is important that you **always stop** the server using the `CTRL + C` shortcut before calling the `start` command again.

    ### Declare site and generate Let's Encrypt Certificate

    At this point, we assume that:

    - your `A record` has been propagated: verify with `ping <YOUR_FQDN>` from your local workstation
    - both port 80 and 443 are free and not blocked by any firewall `sudo netstat -tulpn`

    Create a site:

    ```sh
    sudo su - pydio 
    cells configure sites
    ```

    - Choose "Create a new site"
    - Choose `443` as the port to bind to
    - Enter your FQDN as the address to bind to
    - Choose "Automagically generate certificate with Let's Encrypt"
    - Enter your Email, Accept Let's Encrypt EULA
    - In a first pass, if you have a _complicated_ network setup, you might want to choose to use the staging entrypoint for Let's Encrypt: it has much more _generous_ limitations and let you try/error while fixing glitches in your network setup without getting black-listed. 
    - Redirect default `HTTP` port towards `HTTPS`
    - Double check and save.

    #### Verification

    ```sh
    # Restart your server
    sudo su - pydio 
    cells start
    ```

    Connect to your web site at `https://<YOUR_FQDN>`. A valid certificate is now used.

    Stop your server once again before performing the finalisation steps.

    ## Finalisation

    ### Run your server as a service with systemd

    Create a configuration file `sudo vi /etc/systemd/system/cells.service` with the following:

    ```conf
    [Unit]
    Description=Pydio Cells
    Documentation=https://pydio.com
    Wants=network-online.target
    After=network-online.target
    AssertFileIsExecutable=/opt/pydio/bin/cells

    [Service]
    User=pydio
    Group=pydio
    PermissionsStartOnly=true
    AmbientCapabilities=CAP_NET_BIND_SERVICE
    ExecStart=/opt/pydio/bin/cells start
    Restart=on-failure
    StandardOutput=journal
    StandardError=inherit
    LimitNOFILE=65536
    TimeoutStopSec=5
    KillSignal=INT
    SendSIGKILL=yes
    SuccessExitStatus=0
    WorkingDirectory=/home/pydio

    # Add environment variables
    Environment=CELLS_WORKING_DIR=/var/cells

    [Install]
    WantedBy=multi-user.target
    ```

    Reload systemd daemon, enable and start cells:

    ```sh
    sudo systemctl daemon-reload
    sudo systemctl enable --now cells
    ```

    #### Verification

    ```sh
    # you can check the system logs to insure everything seems OK
    sudo journalctl -fu cells -S -1h
    ```

    Connect to your certified web site at `https://<YOUR_FQDN>`.

    **You are now good to go**. Happy file sharing!

    ## Troubleshooting

    ### Main tips

    With Cells running as a service, you can access the logs in different ways:

    ```sh
    # Pydio file logs
    tail -200f /var/cells/logs/pydio.log
    # Some of the microservices have their own log files, check:
    ls -lsah /var/cells/logs/

    # Check systemd files
    journalctl -fu cells -S -1h
    ```

    ### Time-out while trying to reach the web UI

    If the server is started and you get timeout errors while trying to connect to the web UI, it is generally a sign that the connection to the declared port is blocked by a firewall. Check both on your OS and on the admin console of your machine provider. 

    ### SELinux is enforced

    If, after a successful installation and when you try to navigate to the main application page with your browser, you land on a blank page with following message:

    > Access denied.

    ensure you have modified SELinux to be in permissive mode.

    ### Non standard DB install 

    If the default MariaDB package shipped with your OS does not meet your needs, you can install a more recent version from official MariaDB repository.
    Typically to get version 10.4 on Centos7:

    ```sh
    # Add MariaDB 10.4 CentOS repository list
    # See http://downloads.mariadb.org/mariadb/repositories/
    sudo mkdir -p /etc/yum.repos.d
    sudo tee /etc/yum.repos.d/MariaDB.repo << EOF
    [mariadb]
    name = MariaDB
    baseurl = http://yum.mariadb.org/10.4/centos7-amd64
    gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
    gpgcheck=1
    EOF

    # Install and start the server
    sudo yum install MariaDB-server
    sudo systemctl enable --now mariadb
    ```

=== "[<img src="../../../images/logos-os/debian.png" width="60" >]()"
    _This guide explains how to install and configure Cells on an Debian-like system. It contains strongly opinionated choices and best practices. It explains the steps required for a production-ready and reasonnably secured server. For a simple test, you should rather visit our [quick start page](./quick-start)_.

    **Use case**

    Deploy a self-contained Pydio Cells instance on a web-facing Debian 12 server,  
    exposed at `https://<your-fqdn>` using a Let's Encrypt certificate.

    **Requirements**

    - **CPU/Memory**: 4GB RAM, 2 CPU
    - **Storage**: 100GB SSD hard drive
    - **Operating System**:
    - Debian (10, 11, 12), Ubuntu LTS (18, 20, 22)
    - An admin user with sudo rights that can connect to the server via SSH
    - _Note: The present guide uses a Debian 11 (Bullseye) server. You might have to adapt some commands if you use a different version or flavour._
    - **Networking**:
    - One Network Interface Controller connected to the internet
    - A registered domain that points toward the public IP of your server: if you already know your IP address, it is a good idea to already add a `A Record` in your provider DNS so that the record has been already propagated when we need it.

    ## Installation

    ### Dedicated user and file system layout

    We recommend to run Pydio Cells with a dedicated `pydio` user with **no sudo** permission.

    As admin user on your server:

    ```sh
    # Create pydio user with a home directory
    sudo useradd -m -s /bin/bash pydio

    # Create necessary folders
    sudo mkdir -p /opt/pydio/bin /var/cells
    sudo chown -R pydio: /opt/pydio /var/cells

    # Add system-wide ENV var
    sudo tee -a /etc/profile.d/cells-env.sh << EOF
    export CELLS_WORKING_DIR=/var/cells
    EOF
    sudo chmod 0755 /etc/profile.d/cells-env.sh
    ```

    #### Verification

    Login as user `pydio` and make sure that the environment variables are correctly set:

    ```sh
    sysadmin@server:~$ sudo su - pydio 
    pydio@server:~$ echo $CELLS_WORKING_DIR
    /var/cells
    pydio@server:~$ exit
    ```

    ### Database

    We use the default MariaDB package shipped with Debian Bullseye:

    ```sh
    # Install the server from the default repository
    sudo apt install mariadb-server
    # Run the script to secure your install
    sudo mysql_secure_installation

    # Open MySQL CLI to create your database and a dedicated user
    mysql -u root -p
    ```

    Start a MySQL prompt and create the database and the dedicated `pydio` user.

    ```mysql
    CREATE DATABASE cells;
    CREATE USER 'pydio'@'localhost' IDENTIFIED BY '<PUT YOUR PASSWORD HERE>';
    GRANT ALL PRIVILEGES ON cells.* to 'pydio'@'localhost';
    FLUSH PRIVILEGES;
    ```

    Note: default limits on MariaDB are quite low after install. If your target instance is not small, you probably should adapt them for Cells to run smoothly:

    ```mysql
    SET GLOBAL max_connections = 1000;
    SHOW VARIABLES LIKE "max_connections";
    SET GLOBAL max_prepared_stmt_count = 131056;
    SHOW VARIABLES LIKE "max_prepared_stmt_count";
    ```

    #### Verification

    Check the service is running and that the user `pydio` is correctly created:

    ```sh
    sudo systemctl status mariadb
    mysql -u pydio -p
    ```

    ### Retrieve binary

    ```sh
    # As pydio user
    sudo su - pydio 

    # Download correct binary
    distribId=cells 
    # or for Cells Enterprise
    # distribId=cells-enterprise 
    wget -O /opt/pydio/bin/cells https://download.pydio.com/latest/${distribId}/release/{latest}/linux-amd64/${distribId}

    # Make it executable
    chmod a+x /opt/pydio/bin/cells
    exit

    # As sysadmin user 
    # Add permissions to bind to default HTTP ports
    sudo setcap 'cap_net_bind_service=+ep' /opt/pydio/bin/cells

    # Declare the cells commands system wide
    sudo ln -s /opt/pydio/bin/cells /usr/local/bin/cells
    ```

    #### Verification

    Call the command `version` as user `pydio`:

    ```sh
    sudo su - pydio 
    cells version
    ```

    ## Configuration

    ### Configure the server

    Call the command `configure` as user `pydio`:

    ```sh
    sudo su - pydio 
    cells configure
    ```

    If you choose `Browser install` at the first prompt, you can access the configuration wizard at `https://<YOUR PUBLIC IP>:8080` after accepting the self-signed certificate. (Ensure the port `8080` is free and not blocked by a firewall).

    You can alternatively finalise the configuration from the command line by answering a few questions.

    #### Verification

    If you used the browser install, you can login in the web browser as user `admin`.

    If you have done the CLI install, you first need to start the server:

    ```sh
    sudo su - pydio 
    cells start
    ```

    Connect and login at `https://<YOUR PUBLIC IP>:8080`

    **Note**:  
    At this stage, we start the server in **foreground** mode. In such case, it is important that you **always stop** the server using the `CTRL + C` shortcut before calling the `start` command again.

    ### Declare site and generate Let's Encrypt Certificate

    At this point, we assume that:

    - your `A record` has been propagated: verify with `ping <YOUR_FQDN>` from your local workstation
    - both port 80 and 443 are free and not blocked by any firewall `sudo netstat -tulpn`

    Create a site:

    ```sh
    sudo su - pydio 
    cells configure sites
    ```

    - Choose "Create a new site"
    - Choose `443` as the port to bind to
    - Enter your FQDN as the address to bind to
    - Choose "Automagically generate certificate with Let's Encrypt"
    - Enter your Email, Accept Let's Encrypt EULA
    - Redirect default `HTTP` port towards `HTTPS`  
    - Double check and save.

    Note: if you are not 100% sure of your network setup, we suggest that you first use the staging entry point for Let's Encrypt. You can then avoid being black-listed while fine-tuning and fixing any network issue you might still have at this point.

    #### Verification

    Restart your server:

    ```sh
    sudo su - pydio 
    cells start
    ```

    Connect to your web site at `https://<YOUR_FQDN>`. A valid certificate is now used.

    Stop your server once again before performing the finalisation steps.

    ## Finalisation

    ### Run your server as a service with systemd

    Create a configuration file `sudo vi /etc/systemd/system/cells.service` with the following:

    ```conf
    [Unit]
    Description=Pydio Cells
    Documentation=https://pydio.com
    Wants=network-online.target
    After=network-online.target
    AssertFileIsExecutable=/opt/pydio/bin/cells

    [Service]
    User=pydio
    Group=pydio
    PermissionsStartOnly=true
    AmbientCapabilities=CAP_NET_BIND_SERVICE
    ExecStart=/opt/pydio/bin/cells start
    Restart=on-failure
    StandardOutput=journal
    StandardError=inherit
    LimitNOFILE=65536
    TimeoutStopSec=5
    KillSignal=INT
    SendSIGKILL=yes
    SuccessExitStatus=0
    WorkingDirectory=/home/pydio

    # Add environment variables
    Environment=CELLS_WORKING_DIR=/var/cells

    [Install]
    WantedBy=multi-user.target
    ```

    Reload systemd daemon, enable and start cells:

    ```sh
    sudo systemctl daemon-reload
    sudo systemctl enable --now cells
    ```

    #### Verification

    ```sh
    # you can check the system logs to insure everything seems OK
    journalctl -fu cells -S -1h
    ```

    Connect to your certified web site at `https://<YOUR_FQDN>`.

    ### Add a firewall

    In this tutorial, we use [UncomplicatedFirewall (UFW)](https://wiki.ubuntu.com/UncomplicatedFirewall).

    ```sh
    sudo apt install ufw
    sudo ufw allow ssh
    sudo ufw allow http
    sudo ufw allow https
    sudo systemctl start ufw
    sudo systemctl status ufw
    ```

    If you can still connect to your web GUI and open a ssh connection, even after reboot, **you are now good to go**. 

    Thanks for using Pydio Cells and happy file sharing!

    ## Troubleshooting

    ### Main tips

    With cells as a service, you can access the logs in different ways:

    ```sh
    # Pydio file logs
    tail -200f /var/cells/logs/pydio.log
    # Some of the microservices have their own log files, check:
    ls -lsah /var/cells/logs/

    # Check systemd files
    journalctl -fu cells -S -1h
    ```

=== "[<img src="../../../images/logos-os/macos.png" width="60" >]()"
    _This guide explains how to install and configure Pydio Cells on macOS_.

    Cells comes as a self-contained binary that can be directly run. The only hard requirement is a recent MySQL server. You can use either MySQL (5.7 or 8) or MariaDB 10.3+, both are available in Homebrew.

    `brew install mysql` or `brew install mariadb`

    ## Installation

    ### Pydio

    Download the Pydio Cells binary on your server/machine with the following command:

    ```sh
    # You can use this url as-is: it will be resolved automatically to latest version
    wget https://download.pydio.com/latest/cells/release/{latest}/darwin-amd64/cells
    ```

    ### Port 80 & 443

    You can only use these ports if you are connected as an Admin User or root.

    By default, Apache is running on macOS, so you need to ensure that it - or any other webservers - is not bound to these ports.

    To stop the default Apache, you can use:

    ```sudo apachectl stop```

    To prevent Apache from starting during launch, you may use:

    ```sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist```

    ### Database configuration

    In this section, we assume you have installed MySQL server. Adapt the following steps to your current setup.

    ```sh
    # Go to mysql mode
    sudo mysql -u root
    # Create new user and set password
    CREATE USER 'pydio'@'localhost' IDENTIFIED BY 'your password goes here';
    CREATE DATABASE cells;
    GRANT ALL PRIVILEGES ON cells.* to 'pydio'@'localhost';
    FLUSH PRIVILEGES;
    ```

    ## Starting with Pydio

    First, give execution permission on the file for your user. For instance, you can use `chmod u+x <binary>`.

    Then run the installer with the following command:

    ```sh
    cells configure
    ```

    Once you have finished the configuration, you can start Cells with:

    ```
    cells start
    ```

    By default, the server is started with a self-signed certificate on port 8080: to access the webUI browse to `https://localhost:8080` and accept the certificate.


    To configure a different URL and/or port for Cells, run the following command.

    ```
    cells configure sites
    ```

    ## Troubleshooting

    - The database service might not be started, you can look at its status using : `brew services list` and then `brew services start mysql` if needed.
    - You can look at the webserver's error file located in `/Users/<Your User Name>/Library/Application Support/Pydio/cells`.

=== "[<img src="../../../images/logos-os/windows.png" width="60" >]()"
    This guide shows how to install and run Pydio Cells on Windows 10.

    The binary also work on other version of Windows Desktop (8, 11) and of the Windows Server. Yet, please note that due to the majority of UNIX-like boxes in the enterprise server world and also the lack of feedback from the community, the Windows version of our application might still have unknown glitches and is not officially suported.

    Please feel free to join our [community](https://forum.pydio.com) to improve this. 

    ## Install Cells on Windows 10 

    The only hard requirement is a recent MySQL database. If not yet present on your machine, you can refer to:  

    - [MySQL 8.0](https://dev.mysql.com/doc/refman/8.0/en/windows-installation.html)
    - [MariaDB 10.4](https://mariadb.org/download/)


    You can then download the Pydio Cells executable from [our download server](https://download.pydio.com/latest/cells/release/{latest}/windows-amd64/cells.exe).

    Open a powershell terminal then proceed to install with the following command:

    - `.\cells.exe configure`

    > Note: on Powershell, with legacy version of Cells or Windows, if the arrows keys do not seem to work, you can try with H-J-K-L (J: Up, K: Down).

    > Note: the legacy _Windows Command Prompt_, also known as _CMD_, which is the original shell for the Microsoft DOS operating system and has been the default until Windows 10 is known to have issues with the `Go` language command framework that we use to directly communicate with the server via terminal. On some version, it renders the Cells CLI completely unusable. TL;DR: use `powershell`.

    At first prompt, you can choose how you want to go on with the installation:

    - **Browser based**: opens a tab in your local browser with an intuitive installer.
    - **command line interface**: for advanced users, pretty straight forward.

    Once installed, you can find the application working folder with data, configurations and logs under %APPDATA%.  
    For instance: `C:\Users\pydio\AppData\Roaming\Pydio\cells`.

    > Note: you may have to explicitly allow displaying **hidden files/folders** in your settings to see this folder.

    You can now start Cells and access it at `https://localhost:8080` or `https://<server ip or domain>:8080`

    ```
    .\cells.exe start
    ```

    By default, Cells start on port 8080 with a self-signed certificate. To change this and use a different domain, port or protocol, run:

    ```
    .\cells.exe configure sites
    ```

    ## Troubleshooting

    ### Error message when moving files (license, binary...) 

    You might encounter this message in the logs after performing actions like updating the license or upgrading to the latest version of the server via the in-app process:

    ```
    Update successfully applied but previous binary could not be moved to backup folder     {"error": "remove C:\\<path to you binary file>\\cells-v3.0.9.exe: Access is denied."}
    ```

    This is a known issue and non-blocking: the new file is correctly installed on its intended destination and the app will function normally.