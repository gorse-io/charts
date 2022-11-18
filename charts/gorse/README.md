# Gorse Helm Chart

[Gorse](https://gorse.io) An open-source recommender system service written in Go.

## TL;DR;

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install gorse
```

## Introduction

This chart bootstraps a Gorse deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

**Note**: This chart doesn't support horizontal scaling yet.

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm upgrade --name my-release --install gorse
```

**Note**: Gorse requires a properly configured database in order to initialize. See the `values.yaml` file for the configuration values that need to be set. Also, if preferred you can set `postgresql.enabled` to `true` and Helm will deploy the PostgreSQL chart listed in the `requirements.yaml` file, and Gorse will be able to initialize properly using the default values.

**Note**: Gorse requires a properly configured cahce in order to initialize. See the `values.yaml` file for the configuration values that need to be set. Also, if preferred you can set `redis.enabled` to `true` and Helm will deploy the Redis chart listed in the `requirements.yaml` file, and Gorse will be able to initialize properly using the default values.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm unistall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Gorse chart and their default values.

**Note**: WIP - Table not present - see `values.yaml` file.

Additional configuration parameters for the Redis chart deployed with Gorse can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/redis).

Additional configuration parameters for the PostgreSQL chart deployed with Gorse can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/postgresql).

> **Tip**: You can use the default [values.yaml](values.yaml). this will auto generate some secrets.
