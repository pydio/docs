---
slug: k8s-advanced-parameters
title: K8s Advanced Parameters
description: Deployment example inside a Kubernetes cluster
menu: K8s Advanced Parameters
language: und
weight: 6
menu_name: menu-admin-guide-v7-enterprise

---
Instead of managing manually your own cluster as in the precedent page, you might want to choose a container orchestration tool such as Kubernetes to have a maximum of flexibility on your deployment.
This page gives detailed information on how to run Cells in a multi-node setup using inside Kubernetes.

## What is Kubernetes ?

Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.

### Install a Kubernetes cluster

You can manually [create your own kubernetes cluster](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) on your servers by using kubernetes tools.

Alternatively, there are many operators that offer the possibility of installing a Kubernetes cluster easily. You can find a few below :

- [Amazon Elastic Kubernets Service (EKS)](https://aws.amazon.com/fr/eks/)
- [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine)
- [Microsoft Azure Kubernetes Service (AKS)](https://azure.microsoft.com/fr-fr/free/kubernetes-service/)
- [Scaleway Kubernetes Kapsule](https://www.scaleway.com/fr/kubernetes-kapsule/)

For testing, you can use [minikube](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/) to easily deploy your applications in a local cluster

## What is HELM ?

Helm is essentially a package manager for kubernetes applications. Helm Charts can be defined to easily preconfigure the deployment of an application with its dependencies.

Parameters can be changed by setting them during install or upgrade. (e.g. ```helm install my-cells cells/cells --set image.tag=latest```)

## Kubectl

You can use kubectl locally to easily access your remote cluster. Change your [kubeconfig](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/) to manage and monitor your deployment directly from your computer.
Helm commands will automatically use the kubeconfig configuration.

## Install using Helm

The cells helm charts can be used to deploy a ReplicaSet of Cells stateless servers. Using helm3 you can add the Cells Helm repo as follows :

```
helm repo add cells https://download.pydio.com/pub/charts/helm
helm install --namespace <namespace> --create-namespace my-cells cells/cells
```

------------------------

## Dependencies

> **v5 change — bundled subcharts are deprecated.**
> In v5, the recommended path is to point Cells at **externally-managed services** (in-cluster operators, managed cloud services, or your own deployments). The bundled subcharts listed below are still shipped for quick local trials and CI but are no longer maintained as the default deployment target — production setups should configure each backend as an external service via Cells' connection strings and disable the matching subchart.

Each dependency parameter can be configured directly from the command line by adding the name of the dependency as prefix :

```
helm install my-cells cells/cells --set mariadb.image.tag=latest ...
```

To run against your own deployment, disable the bundled subchart and point Cells at your external service in the configuration:

```
helm install my-cells cells/cells --set mariadb.enabled=false
```

Cells Chart declares the following dependencies below. They are **all** necessary for a fully functional Cells cluster — either by enabling the bundled subchart (trials) or by configuring an external equivalent (production)

| Name                                                                     | Repo                                          | Enable            | Parameters list                                                 |
|--------------------------------------------------------------------------|-----------------------------------------------|-------------------|-----------------------------------------------------------------|
| [mariadb](https://github.com/bitnami/charts/tree/master/bitnami/mariadb) | [bitnami](https://charts.bitnami.com/bitnami) | `mariadb.enabled` | https://artifacthub.io/packages/helm/bitnami/mariadb#parameters |
| PostgreSQL (external only) | n/a — supply your own | configure DSN | See [PostgreSQL support](#) — no bundled subchart, must be supplied externally |
| [redis](https://github.com/bitnami/charts/tree/master/bitnami/redis)     | [bitnami](https://charts.bitnami.com/bitnami) | `redis.enabled`   | https://artifacthub.io/packages/helm/bitnami/redis#parameters   | 
| [nats](https://github.com/bitnami/charts/tree/master/bitnami/nats)       | [bitnami](https://charts.bitnami.com/bitnami) | `nats.enabled`    | https://artifacthub.io/packages/helm/bitnami/nats#parameters    |
| [mongodb](https://github.com/bitnami/charts/tree/master/bitnami/mongodb) | [bitnami](https://charts.bitnami.com/bitnami) | `mongodb.enabled` | https://artifacthub.io/packages/helm/bitnami/mongodb#parameters | 
| [minio](https://github.com/bitnami/charts/tree/master/bitnami/minio)     | [bitnami](https://charts.bitnami.com/bitnami)   | `minio.enabled`   | https://artifacthub.io/packages/helm/bitnami/minio#parameters   |
| [vault](https://www.vaultproject.io/docs/platform/k8s/helm/configuration) | [Hashicorp](https://helm.releases.hashicorp.com) | `vault.enabled`    | https://developer.hashicorp.com/vault/docs/platform/k8s/helm/configuration |

Cells Chart declares the following **optional** dependencies below

| Name                                                                                        | Repo       | Enable            | Parameters list                                                         |
|---------------------------------------------------------------------------------------------|------------|-------------------|-------------------------------------------------------------------------|
| [ingress-nginx](https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx) | kubernetes | `ingress.enabled` | https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx#values |

## cells-controller

The chart deploys a dedicated `cells-controller` workload (a single-replica Deployment) alongside the `cells` ReplicaSet. The controller mediates Kubernetes ConfigMaps and Secrets at runtime — Cells pods stay stateless and read their configuration through the controller, which keeps cluster-wide state consistent (TLS certs, dynamic configuration, master keys via Vault, etc.). You should not need to interact with it directly, but be aware that it must be running for installs and upgrades to complete.

## OpenShift

A first OpenShift deployment template is included in the v5 chart. The main differences are around security contexts and route resources; see `tools/kubernetes/cells/` in the Cells repository for the template and the `openshift` value flag in `values.yaml`.

## Configuration

### Number of replicas

| Parameter    | Description                                           | Default      |
| --- | --- | --- |
| `replicaCount` | Number of replicas used be default by the application | 1            |

### Server image

| Parameter        | Description  | Default      |
| --- | --- | --- |
| `image.repository` |              | pydio/cells  |
| `image.pullPolicy` |              | IfNotPresent |
| `image.tag`        |              | unstable     |

### Service

| Parameter                | Description                                           | Default                                                                                                                                                                                                                                                                                                |
|--------------------------|-------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `service.type`           |                                                       | NodePort                                                                                                                                                                                                                                                                                               |
| `service.port`           |                                                       | 8080                                                                                                                                                                                                                                                                                                   |
| `service.discoveryPort`  |                                                       | 8002                                                                                                                                                                                                                                                                                                   |
| `service.binds`          | Configures new bind addresses for the pod             | *not set*                                                                                                                                                                                                                                                                                              |
| `service.reverseproxyurl` | Configure the reverse proxy url for the pod           | *not set*                                                                                                                                                                                                                                                                                              |
| `service.tlsconfig` | Configure the tlsconfig of the pod load balancer      | *not set*                                                                                                                                                                                                                                                                                              |
| `service.customconfigs` | Configure custom configuration for the Cells instance | {<br>&nbsp;# Initial license<br>&nbsp;"defaults/license/data": "FAKE",<br><br>&nbsp;# sticky session for grpc<br>&nbsp;"cluster/clients/grpc/loadBalancingStrategies[0]/name": "priority-local",<br><br>&nbsp;#<br>&nbsp;"frontend/plugin/core.pydio/APPLICATION_TITLE": "My Pydio Cells Cluster"<br>} |

## Resources

Resources are not set by default in order to run everywhere.

But it becomes mandatory if you want to set up an autoscaling strategy (below)

| Parameter                    | Description  | Default   |
|------------------------------| --- |-----------|
 | `resources.limits.cpu`       | | *not set* |
 | `resources.limits.memory`    | | *not set* |
 | `resources.requests.cpu`     | | *not set* |
| `resources.requests.memory`  | | *not set* |

## Autoscaling

Autoscaling is disabled by default. But you can enable it to have the replica set horizontally scaling to use the full (or as defined) capacity of your cluster.

| Parameter           | Description                                                                                               | Default |
|---------------------|-----------------------------------------------------------------------------------------------------------|---------|
| `autoscaling.enabled` | Enables autoscaling                                                                                       | false   |
| `autoscaling.minReplicas` | Minimum number of replicas started for a Cells deployment                                                 | 3       |
| `autoscaling.maxReplicas` | Maximum number of replicas started for a Cells deployment                                                 | 5       |
| `autoscaling.targetCPUUtilizationPercentage` | Target cpu percentage usage of the maximum resource allocated to reach to trigger a new pod deployment    | 80      |
| `autoscaling.targetMemoryUtilizationPercentage` | Target memory percentage usage of the maximum resource allocated to reach to trigger a new pod deployment | 80      |

## Ingress

In order to access your application remotely, you can set an ingress API object that will provide load balancing, SSL termination and name-based virtual hosting :

| Parameter                      | Description                              | Default     |
|--------------------------------|------------------------------------------|-------------|
| `ingress.enabled`              | 	Enables Ingress	                        | false       |
| `ingress.annotations`          | Ingress annotations	                     | {<br>"kubernetes.io/ingress.class": "nginx",<br>&nbsp;"cert-manager.io/cluster-issuer": "letsencrypt",<br>&nbsp;"nginx.ingress.kubernetes.io/proxy-body-size": "0"<br>}         | 
| `ingress.hostname`	            | Ingress main hostname                    | cells.local |
| `ingress.tls`	                 | Ingress TLS enabled                      | false       |
| `ingress.clusterissuer.server` | URL to the LetsEncrypt certification API | https://acme-v02.api.letsencrypt.org/directory |
| `ingress.clusterissuer.email` | Email used for verification during the certification | *not set* |
| `ingress.extraHosts` | Potential extra hostnames allowed | [] |


## Nats Jetstream queue

In cells helm chart `version <= 0.1.2`, you should manually modify `deployment.yaml` to add an env for persist queue as well as activate nats jetstream in `values.yaml`

### Update deployment.yaml

Add an extra environment variable (CELLS_PERSISTQUEUE) to instruct Cells to use the NATS service as a queue.
Modify the containers section as follows:

```
containers:
  - name: {{ .Chart.Name }}
    args:
      ['-c', 'source /var/cells-install/source && cells start ']
    env:
      - name: POD_NAME
        valueFrom:
          fieldRef:
            fieldPath: metadata.name
      - name: CELLS_PERSISTQUEUE
        value: {{ include "cells.natsURL" . }}

```

### Update values.yaml

When NATS starts with JetStream, it transitions from a Deployment to a StatefulSet. This change requires adding a PersistentVolume to the cluster.
An example configuration for NATS in values.yaml:

```
nats:
  enabled: true
  jetstream:
    enabled: true
    maxMemory: 5G
  auth:
    enabled: false
  volumePermissions:
    enabled: true

  # Allow pod to write to the mounted repository
  podSecurityContext: { enabled: true }

  persistence:
    enabled: true 
    storageClass: gp2
    annotations: {}
    accessModes:
      - ReadWriteOnce
    size: 8Gi
    selector: {}
  debug:
    enabled: true
  resourceType: statefulset

  ## Number of NATS nodes
  replicaCount: 3
  cluster:
    name: nats
    connectRetries: ""
    auth:
      enabled: false
      user: nats_cluster
      password: "secret-changeme"

```      

> Note: The `podSecurityContext: { enabled: true }` setting is required for proper functionality.
