# The Gorse Library for Kubernetes

To install a chart from this repo you need to run:

```bash
$ helm repo add gorse-io https://charts.gorse.io
$ helm search repo gorse-io --devel
```

> **NOTE:** some chart **might** require the `bitnami` repository already installed.

## Gorse Installation

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm repo add gorse-io https://charts.gorse.io
$ helm upgrade --name my-release --install gorse-io/gorse --devel
```

For full documentation see the `gorse` [README](https://github.com/gorse-io/charts/blob/main/charts/gorse/README.md).
