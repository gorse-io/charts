# The Gorse Library for Kubernetes
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/gorse-io)](https://artifacthub.io/packages/search?repo=gorse-io)

To install a chart from this repo you need to run:

```bash
helm repo add gorse-io https://charts.gorse.io
helm search repo gorse-io
```

There are charts available in this repo:

| Name | Description |
|-|-|
| [gorse](./charts/gorse) | Gorse Recommender System Engine |
| [gorse-enterprise](./charts/gorse-enterprise) | Gorse Enterprise Recommender System Engine |
| [gorse-manager](./charts/gorse-manager) | Gorse Cloud Manager for Kubernetes | 

> **NOTE:** The [bitnami](https://github.com/bitnami/charts) repository is required.
