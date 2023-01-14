# Gorse Helm Chart

[Gorse](https://gorse.io) An open-source recommender system service written in Go.

## TL;DR;

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm repo add gorse-io https://charts.gorse.io
$ helm upgrade --name my-release --install gorse-io/gorse --devel
```

## Introduction

This chart bootstraps a Gorse deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

> **Note**: This chart doesn't support horizontal scaling yet.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release` in the `gorse` namespace:

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm repo add gorse-io https://charts.gorse.io
$ helm upgrade --name my-release --install gorse-io/gorse --create-namespace --namespace gorse --devel
```

The command deploys Gorse on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: Tou can override the default values by passing `-f ./values.yaml` to the `helm upgrade` command.

**Note**: Gorse requires a properly configured database in order to initialize. See the `values.yaml` file for the configuration values that need to be set. Also, if preferred you can set `postgresql.enabled` to `true` and Helm will deploy the PostgreSQL chart, and Gorse will be able to initialize properly using the default values. (**UNTESTED**)

**Note**: Gorse requires a properly configured cahce in order to initialize. See the `values.yaml` file for the configuration values that need to be set. Also, if preferred you can set `redis.enabled` to `true` and Helm will deploy the Redis chart, and Gorse will be able to initialize properly using the default values. (**UNTESTED**)

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment in the `gorse` namespace:

```bash
$ helm unistall my-release --namespace gorse
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

## Configuration

Additional configuration parameters for the Redis chart deployed with Gorse can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/redis).

Additional configuration parameters for the PostgreSQL chart deployed with Gorse can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/postgresql).

> **Tip**: You can use the default [values.yaml](values.yaml). this will auto generate some secrets.
