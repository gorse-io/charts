# The Gorse Library for Kubernetes

To install a chart from this repo you need to run:

```bash
$ helm repo add my-repo https://charts.gorse.io
$ helm search repo my-repo
$ helm install my-release my-repo/<charts>
```

> **TIP:** replace `my-release` with the chart you want to install.

> **NOTE:** some chart **might** require the `bitnami` repository already installed.

## Gorse Installation

**TL;DR:**

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm repo add gorse-io https://charts.gorse.io
$ helm install gorse-io/gorse
```

For full documentation see the `gorse` [Readme](https://github.com/gorse-io/charts/blob/main/charts/gorse/README.md).
