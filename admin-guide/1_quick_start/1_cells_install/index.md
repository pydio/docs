---
title: Cells Installation
abstract: Getting started with Pydio Cells using pre-compiled binaries or cloud images.
menu: Cells Installation
language: und
weight: 2
menu_name: menu-admin-guide-v7-enterprise
---

<style type="text/css">
ol.install-steps {
padding-left: 0 !important;
list-style: none;
counter-reset: my-awesome-counter;
padding: 0;
margin:0;
}
ol.install-steps li {
counter-increment: my-awesome-counter;
border-left: 2px solid #08cc99;
display:flex;
align-items: baseline;
background-color: #ecf8f6;
padding: 16px 20px;
margin: 20px 0 !important;
}

ol.install-steps li::before {
content: counter(my-awesome-counter) ". ";
color: #44d2ab;
font-weight: bold;
margin-right: 10px;
font-size: 22px;
}


ol.install-steps li p {
display: inline;
margin: 0 !important;
font-size: 18px !important;
}

ol.install-steps li code {
    font-size: 16px !important;
    display: block;
    margin: 0px 0 !important;
    padding: 6px !important;
    background-color: rgb(42 42 53 / 95%) !important;
    color: white !important;
    width: 270px;
    margin-top: 6px !important;
}

ol span.geshifilter {
    display: inherit;
}

.install-logos {
    display: flex;
    flex-wrap: wrap;
}

.install-logos .logo-img {
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.install-logos a.logo {
    color: inherit;
    text-align: center;
    font-size: 12px;
    font-weight: bold;
    margin: 5px;
    border: 2px solid #97E6D1;
    border-radius: 4px;
    padding: 5px;
    background-color: #ecf8f6;
    width: 110px;
    cursor: pointer;
}

.install-logos img {
    border: none !important;
}

.install-logos .logo-title {
    padding-top: 5px;
}

</style>


### Select your installation type

Get started quickly with Cells static binaries, or pick an image for your cloud environment. 

=== "[<img src="../../../images/logos-os/binaries.png" width="60" >]()"

    ## Using pre-built binaries

    Download latest build from [pydio.com](https://pydio.com/en/download) and make it executable, then run 

    ```sh
    $ ./cells configure # you will be asked for DB Credentials
    $ ./cells start
    ```
    Open your browser at <a href="https://localhost:8080" target="_blank">https://localhost:8080</a, _voilà_!

    [Detailed Instructions](./1_static_binaries.md){ .md-button .md-button--primary }

=== "[<img src="../../../images/logos-os/docker.png" width="60">]()"

    ## Using Docker Images

    Our images are hosted on Docker Hub: 

    ```sh
    docker run -d --network=host pydio/cells
    ```

    [Docker / Docker Compose instructions](./2_docker.md){ .md-button .md-button--primary }

=== "[<img src="../../../images/logos-os/ovf.png" width="60">]()"

    ## Using OVF Image

    Download the [latest OVF image](https://download.pydio.com/latest/cells-enterprise/release/{latest}/ovf/Cells-Enterprise-OVF-{latest}.zip).

    [OVF Image Details](./5_ovf.md){ .md-button .md-button--primary }

=== "[<img src="../../../images/logos-os/amazon.png" width="60">]()"

    An Amazon Machine Image (AMI) for Cells Enterprise Distribution is available on [on the Amazon Web Services Marketplace](https://aws.amazon.com/marketplace/pp/B08CNGR8ZP).

    [AMI Image Instructions](./7_AMI.md){ .md-button .md-button--primary }

=== "[<img src="../../../images/logos-os/logo-kubernetes.png" width="50">]()"

    ## Kubernetes Deployment

    Pydio Cells Helm Chart is available at https://download.pydio.com/pub/charts/helm. Add this repository and run
    ```sh
        $ helm install cells cells/cells --namespace cells --create-namespace
    ```

    [Detailed Clustered Deployment Instructions](../../../run-cells-in-production/deploying-cells-in-a-distributed-environment/kubernetes-quick-install){ .md-button .md-button--primary }

