# Gorse Helm Chart

[Gorse](https://gorse.io) An open-source recommender system service written in Go.

## TL;DR

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add gorse-io https://charts.gorse.io
helm install gorse gorse-io/gorse
```

## Introduction

This chart bootstraps a Gorse deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It also packages the [Bitnami MongoDB chart](https://github.com/bitnami/charts/tree/main/bitnami/mongodb) which is required for bootstrapping a MongoDB deployment for the database requirements of the Gorse application.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `gorse`:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add gorse-io https://charts.gorse.io
helm install gorse gorse-io/gorse
```

The command deploys Gorse on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Architecture

Gorse supports two deployment architectures:

### Distributed (Default)

Full cluster deployment with separate Master, Worker, and Server components. Suitable for production workloads.

```bash
helm install gorse gorse-io/gorse --set architecture=distributed
```

### Standalone

Single gorse-in-one container for development and testing. All components run in a single pod.

```bash
helm install gorse gorse-io/gorse --set architecture=standalone
```

## Uninstalling the Chart

To uninstall/delete the `gorse` deployment:

```bash
helm uninstall gorse
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `""`  |

### Common parameters

| Name                | Description                                        | Value           |
| ------------------- | -------------------------------------------------- | --------------- |
| `kubeVersion`       | Override Kubernetes version                        | `""`            |
| `nameOverride`      | String to partially override common.names.fullname | `""`            |
| `fullnameOverride`  | String to fully override common.names.fullname     | `""`            |
| `commonLabels`      | Labels to add to all deployed objects              | `{}`            |
| `commonAnnotations` | Annotations to add to all deployed objects         | `{}`            |
| `secretAnnotations` | Annotations to add to secret                       | `{}`            |
| `clusterDomain`     | Default Kubernetes cluster domain                  | `cluster.local` |

### Architecture parameters

| Name           | Description                                                                                                | Value        |
| -------------- | ---------------------------------------------------------------------------------------------------------- | ------------ |
| `architecture` | Gorse deployment architecture. Allowed values: `standalone` (gorse-in-one) or `distributed` (full cluster) | `distributed` |

### Gorse Configuration parameters

| Name                         | Description                     | Value   |
| ---------------------------- | ------------------------------- | ------- |
| `gorse.dashboard.username`   | Username for the dashboard.     | `gorse` |
| `gorse.dashboard.password`   | Password for the dashboard.     | `""`    |
| `gorse.dashboard.authServer` | Token server for the dashboard. | `""`    |

### Recommend Configuration (TOML string)

| Name              | Description                                    | Value |
| ----------------- | ---------------------------------------------- | ----- |
| `gorse.recommend` | TOML string for recommend configuration.       | `""`  |

#### Recommend TOML Example

```yaml
gorse:
  recommend: |
    [recommend]
    cache_size = 100
    cache_expire = "72h"
    
    [recommend.data_source]
    positive_feedback_types = ["star", "like"]
    read_feedback_types = ["read"]
    
    [[recommend.item-to-item]]
    name = "neighbors"
    type = "embedding"
    column = "item.Labels.embedding"
    
    [[recommend.user-to-user]]
    name = "neighbors"
    type = "items"
    
    [recommend.collaborative]
    enable = true
    fit_period = "60m"
    fit_epoch = 100
    
    [recommend.ranker]
    type = "fm"
    recommenders = ["latest", "collaborative", "item-to-item/neighbors", "user-to-user/neighbors"]
```

### Master SSL

| Name                                            | Description                                               | Value   |
| ----------------------------------------------- | --------------------------------------------------------- | ------- |
| `gorse.master.ssl.mode`                         | Enable SSL for the gRPC communication.                    | `false` |
| `gorse.master.ssl.ca`                           | SSL certification authority for the gRPC communication.   | `""`    |
| `gorse.master.ssl.cert`                         | SSL certification for the gRPC communication.             | `""`    |
| `gorse.master.ssl.key`                          | SSL certification key for the gRPC communication.         | `""`    |
| `gorse.api.key`                                 | The key to secure the API endpoint                        | `""`    |
| `gorse.api.corsDomains`                         | List of allowed values for Http Origin                    | `[]`    |
| `gorse.api.corsMethods`                         | List of http methods names. Checking is case-insensitive. | `[]`    |
| `gorse.api.autoInsertUsers`                     | Insert new users while inserting feedback                 | `true`  |
| `gorse.api.autoInsertItems`                     | Insert new items while inserting feedback.                | `true`  |
| `gorse.api.returnSize`                          | Default number of returned items                          | `10`    |
| `gorse.api.serverCacheExpire`                   | Server-side cache expire time                             | `10s`   |

### OIDC configuration

| Name                      | Description                          | Value   |
| ------------------------- | ------------------------------------ | ------- |
| `gorse.oidc.enable`       | Enable OpenID Connect authentication | `false` |
| `gorse.oidc.issuer`       | OAuth provider issuer                | `""`    |
| `gorse.oidc.clientId`     | OAuth application client ID          | `""`    |
| `gorse.oidc.clientSecret` | OAuth application client secret      | `""`    |
| `gorse.oidc.redirectUrl`  | OAuth redirect/callback URL          | `""`    |
