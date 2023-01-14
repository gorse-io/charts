# The Gorse Library for Kubernetes

To install a chart from this repo you need to run:

```bash
$ helm repo add gorse-io https://charts.gorse.io
$ helm search repo gorse-io --devel
```

There are charts available in this repo:

| Name | Description |
|-|-|
| [gorse](./charts/gorse) | Gorse Recommender System Engine |
| [gorse-manager](./charts/gorse-manager) | Gorse Cloud Manager for Kubernetes | 

> **NOTE:** Some chart **might** require the `bitnami` repository already installed.
