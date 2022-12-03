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

### Global parameters

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

### Gorse Configuration

| Name                                         | Description                                                                   | Value             |
| -------------------------------------------- | ----------------------------------------------------------------------------- | ----------------- |
| `gorse.cache.uri`                            | URI used to connect Gorse to the cache                                        | `""`              |
| `gorse.database.uri`                         | URI used to connect Gorse to the database                                     | `""`              |
| `gorse.database.prefix`                      | Table prefix of database and cache                                            | `""`              |
| `gorse.auth.dashboard.enabled`               | Enable login in Gorse dashboard                                               | `false`           |
| `gorse.auth.dashboard.username`              | Password for the custom user to dashboard.                                    | `gorse`           |
| `gorse.auth.dashboard.password`              | Password for the custom user to create.                                       | `""`              |
| `gorse.auth.api.enabled`                     | Enable API security via token                                                 | `false`           |
| `gorse.auth.api.key`                         | The key to secure the API andpoint                                            | `""`              |
| `gorse.master.http.cors.domains`             | List of allowed values for Http Origin                                        | `[]`              |
| `gorse.master.http.cors.methods`             | List of http methods names. Checking is case-insensitive.                     | `[]`              |
| `gorse.master.jobs`                          | Number of working jobs in the master node                                     | `1`               |
| `gorse.server.items`                         | Default number of returned items                                              | `10`              |
| `gorse.server.insert.users`                  | Insert new users while inserting feedback                                     | `true`            |
| `gorse.server.insert.items`                  | Insert new items while inserting feedback.                                    | `true`            |
| `gorse.server.cache.expire`                  | Server-side cache expire time                                                 | `10s`             |
| `gorse.recommend.cache.size`                 | The cache size for recommended/popular/latest items                           | `10`              |
| `gorse.recommend.cache.expire`               | Recommended cache expire time                                                 | `72h`             |
| `gorse.recommend.ttl.feedback`               | The time-to-live (days) of positive feedback                                  | `0`               |
| `gorse.recommend.ttl.item`                   | The time-to-live (days) of items                                              | `0`               |
| `gorse.recommend.ttl.popular`                | The time window of popular items                                              | `4320h`           |
| `gorse.recommend.feedback.positive`          | The feedback types for positive events                                        | `["star","like"]` |
| `gorse.recommend.feedback.read`              | The feedback types for read events.                                           | `["read"]`        |
| `gorse.recommend.neighbors.users.type`       | The type of neighbors for users                                               | `similar`         |
| `gorse.recommend.neighbors.items.type`       | The type of neighbors for items.                                              | `similar`         |
| `gorse.recommend.collaborative.enable`       | Enable approximate collaborative filtering recommend using vector index       | `true`            |
| `gorse.recommend.replacement.enable`         | Replace historical items back to recommendations                              | `false`           |
| `gorse.recommend.replacement.decay.positive` | Decay the weights of replaced items from positive feedbacks                   | `0.8`             |
| `gorse.recommend.replacement.decay.read`     | Decay the weights of replaced items from read feedbacks                       | `0.6`             |
| `gorse.recommend.online.failback`            | The fallback recommendation method is used when cached recommendation drained | `["latest"]`      |

### Gorse master node parameters

| Name                                      | Description                                                                                                                      | Value                    |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `master.image.registry`                   | Gorse image registry                                                                                                             | `docker.io`              |
| `master.image.repository`                 | Gorse Master image repository                                                                                                    | `zhenghaoz/gorse-master` |
| `master.image.tag`                        | Gorse Master image tag (immutable tags are recommended)                                                                          | `0.4.9`                  |
| `master.image.digest`                     | Gorse Master image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag                     | `""`                     |
| `master.image.pullPolicy`                 | Gorse Master image pull policy                                                                                                   | `IfNotPresent`           |
| `master.image.pullSecrets`                | Specify docker-registry secret names as an array                                                                                 | `[]`                     |
| `master.kind`                             | Use either Deployment or StatefulSet (default)                                                                                   | `StatefulSet`            |
| `master.persistence.enabled`              | Enable persistence on Gorse master nodes using Persistent Volume Claims                                                          | `true`                   |
| `master.persistence.medium`               | Provide a medium for `emptyDir` volumes.                                                                                         | `""`                     |
| `master.persistence.sizeLimit`            | Set this to enable a size limit for `emptyDir` volumes.                                                                          | `""`                     |
| `master.persistence.path`                 | The path the volume will be mounted at on Gorse master containers                                                                | `/var/lib/gorse`         |
| `master.persistence.subPath`              | The subdirectory of the volume to mount on Gorse master containers                                                               | `""`                     |
| `master.persistence.subPathExpr`          | Used to construct the subPath subdirectory of the volume to mount on Gorse master containers                                     | `""`                     |
| `master.persistence.storageClass`         | Persistent Volume storage class                                                                                                  | `""`                     |
| `master.persistence.accessModes`          | Persistent Volume access modes                                                                                                   | `["ReadWriteOnce"]`      |
| `master.persistence.size`                 | Persistent Volume size                                                                                                           | `8Gi`                    |
| `master.persistence.annotations`          | Additional custom annotations for the PVC                                                                                        | `{}`                     |
| `master.persistence.selector`             | Additional labels to match for the PVC                                                                                           | `{}`                     |
| `master.persistence.dataSource`           | Custom PVC data source                                                                                                           | `{}`                     |
| `master.persistence.existingClaim`        | Use a existing PVC which must be created manually before bound                                                                   | `""`                     |
| `master.service.type`                     | Gorse master service type                                                                                                        | `ClusterIP`              |
| `master.service.ports.http`               | HTTP port of the master node (dashboard)                                                                                         | `80`                     |
| `master.service.ports.grpc`               | GRPC port of the master node                                                                                                     | `8086`                   |
| `master.service.nodePorts.http`           | HTTP port of the master node (dashboard)                                                                                         | `""`                     |
| `master.service.nodePorts.grpc`           | GRPC port of the master node                                                                                                     | `""`                     |
| `master.service.externalTrafficPolicy`    | Gorse master service external traffic policy                                                                                     | `Cluster`                |
| `master.service.extraPorts`               | Extra ports to expose (normally used with the `sidecar` value)                                                                   | `[]`                     |
| `master.service.internalTrafficPolicy`    | Gorse master service internal traffic policy (requires Kubernetes v1.22 or greater to be usable)                                 | `Cluster`                |
| `master.service.clusterIP`                | Gorse master service Cluster IP                                                                                                  | `""`                     |
| `master.service.loadBalancerIP`           | Gorse master service Load Balancer IP                                                                                            | `""`                     |
| `master.service.loadBalancerSourceRanges` | Gorse master service Load Balancer sources                                                                                       | `[]`                     |
| `master.service.annotations`              | Additional custom annotations for Gorse master service                                                                           | `{}`                     |
| `master.service.sessionAffinity`          | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                                                             | `None`                   |
| `master.service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                                      | `{}`                     |
| `master.ingress.enabled`                  | Enable ingress controller resource                                                                                               | `false`                  |
| `master.ingress.pathType`                 | Ingress Path type                                                                                                                | `ImplementationSpecific` |
| `master.ingress.apiVersion`               | Override API Version (automatically detected if not set)                                                                         | `""`                     |
| `master.ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                     |
| `master.ingress.hostname`                 | Default host for the ingress resource                                                                                            | `gorse.local`            |
| `master.ingress.path`                     | The Path to Gorse. You may need to set this to '/\*' in order to use this                                                        | `/`                      |
| `master.ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                     |
| `master.ingress.tls`                      | Enable TLS configuration for the hostname defined at ingress.hostname parameter                                                  | `false`                  |
| `master.ingress.extraHosts`               | The list of additional hostnames to be covered with this ingress record.                                                         | `[]`                     |
| `master.ingress.extraPaths`               | Any additional arbitrary paths that may need to be added to the ingress under the main host.                                     | `[]`                     |
| `master.ingress.extraTls`                 | The tls configuration for additional hostnames to be covered with this ingress record.                                           | `[]`                     |
| `master.ingress.secrets`                  | If you're providing your own certificates, please use this to add the certificates as secrets                                    | `[]`                     |
| `master.ingress.extraRules`               | Additional rules to be covered with this ingress record                                                                          | `[]`                     |
| `master.resources.limits`                 | The resources limits for the Gorse replicas containers                                                                           | `{}`                     |
| `master.resources.requests`               | The requested resources for the Gorse replicas containers                                                                        | `{}`                     |
| `master.podAffinityPreset`                | Pod affinity preset. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`                                       | `""`                     |
| `master.podAntiAffinityPreset`            | Pod anti-affinity preset. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`                                  | `soft`                   |
| `master.nodeAffinityPreset.type`          | Node affinity preset type. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`                                 | `""`                     |
| `master.nodeAffinityPreset.key`           | Node label key to match. Ignored if `master.affinity` is set                                                                     | `""`                     |
| `master.nodeAffinityPreset.values`        | Node label values to match. Ignored if `master.affinity` is set                                                                  | `[]`                     |
| `master.affinity`                         | Affinity for Gorse master pods assignment                                                                                        | `{}`                     |
| `master.nodeSelector`                     | Node labels for Gorse master pods assignment                                                                                     | `{}`                     |
| `master.tolerations`                      | Tolerations for Gorse master pods assignment                                                                                     | `[]`                     |
| `master.pdb.create`                       | Specifies whether a PodDisruptionBudget should be created                                                                        | `false`                  |
| `master.pdb.minAvailable`                 | Min number of pods that must still be available after the eviction                                                               | `1`                      |
| `master.pdb.maxUnavailable`               | Max number of pods that can be unavailable after the eviction                                                                    | `""`                     |

### Gorse server node parameters

| Name                                      | Description                                                                                                                      | Value                    |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `server.image.registry`                   | Gorse image registry                                                                                                             | `docker.io`              |
| `server.image.repository`                 | Gorse Server image repository                                                                                                    | `zhenghaoz/gorse-server` |
| `server.image.tag`                        | Gorse Server image tag (immutable tags are recommended)                                                                          | `0.4.9`                  |
| `server.image.digest`                     | Gorse Server image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag                     | `""`                     |
| `server.image.pullPolicy`                 | Gorse Server image pull policy                                                                                                   | `IfNotPresent`           |
| `server.image.pullSecrets`                | Specify docker-registry secret names as an array                                                                                 | `[]`                     |
| `server.service.type`                     | Gorse server service type                                                                                                        | `ClusterIP`              |
| `server.service.ports.http`               | Gorse server service port                                                                                                        | `80`                     |
| `server.service.nodePorts.http`           | Node port for Gorse server                                                                                                       | `""`                     |
| `server.service.externalTrafficPolicy`    | Gorse server service external traffic policy                                                                                     | `Cluster`                |
| `server.service.extraPorts`               | Extra ports to expose (normally used with the `sidecar` value)                                                                   | `[]`                     |
| `server.service.internalTrafficPolicy`    | Gorse server service internal traffic policy (requires Kubernetes v1.22 or greater to be usable)                                 | `Cluster`                |
| `server.service.clusterIP`                | Gorse server service Cluster IP                                                                                                  | `""`                     |
| `server.service.loadBalancerIP`           | Gorse server service Load Balancer IP                                                                                            | `""`                     |
| `server.service.loadBalancerSourceRanges` | Gorse server service Load Balancer sources                                                                                       | `[]`                     |
| `server.service.annotations`              | Additional custom annotations for Gorse server service                                                                           | `{}`                     |
| `server.service.sessionAffinity`          | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                                                             | `None`                   |
| `server.service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                                      | `{}`                     |
| `server.ingress.enabled`                  | Enable ingress controller resource                                                                                               | `false`                  |
| `server.ingress.pathType`                 | Ingress Path type                                                                                                                | `ImplementationSpecific` |
| `server.ingress.apiVersion`               | Override API Version (automatically detected if not set)                                                                         | `""`                     |
| `server.ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                     |
| `server.ingress.hostname`                 | Default host for the ingress resource                                                                                            | `api.gorse.local`        |
| `server.ingress.path`                     | The Path to Gorse. You may need to set this to '/\*' in order to use this                                                        | `/`                      |
| `server.ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                     |
| `server.ingress.tls`                      | Enable TLS configuration for the hostname defined at ingress.hostname parameter                                                  | `false`                  |
| `server.ingress.extraHosts`               | The list of additional hostnames to be covered with this ingress record.                                                         | `[]`                     |
| `server.ingress.extraPaths`               | Any additional arbitrary paths that may need to be added to the ingress under the main host.                                     | `[]`                     |
| `server.ingress.extraTls`                 | The tls configuration for additional hostnames to be covered with this ingress record.                                           | `[]`                     |
| `server.ingress.secrets`                  | If you're providing your own certificates, please use this to add the certificates as secrets                                    | `[]`                     |
| `server.ingress.extraRules`               | Additional rules to be covered with this ingress record                                                                          | `[]`                     |
| `server.autoscaling.enabled`              | Enable replica autoscaling settings                                                                                              | `false`                  |
| `server.autoscaling.minReplicas`          | Minimum replicas for the pod autoscaling                                                                                         | `1`                      |
| `server.autoscaling.maxReplicas`          | Maximum replicas for the pod autoscaling                                                                                         | `11`                     |
| `server.autoscaling.targetCPU`            | Percentage of CPU to consider when autoscaling                                                                                   | `""`                     |
| `server.autoscaling.targetMemory`         | Percentage of Memory to consider when autoscaling                                                                                | `""`                     |
| `server.resources.limits`                 | The resources limits for the Gorse replicas containers                                                                           | `{}`                     |
| `server.resources.requests`               | The requested resources for the Gorse replicas containers                                                                        | `{}`                     |
| `server.podAffinityPreset`                | Pod affinity preset. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`                                       | `""`                     |
| `server.podAntiAffinityPreset`            | Pod anti-affinity preset. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`                                  | `soft`                   |
| `server.nodeAffinityPreset.type`          | Node affinity preset type. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`                                 | `""`                     |
| `server.nodeAffinityPreset.key`           | Node label key to match. Ignored if `server.affinity` is set                                                                     | `""`                     |
| `server.nodeAffinityPreset.values`        | Node label values to match. Ignored if `server.affinity` is set                                                                  | `[]`                     |
| `server.affinity`                         | Affinity for Gorse server pods assignment                                                                                        | `{}`                     |
| `server.nodeSelector`                     | Node labels for Gorse server pods assignment                                                                                     | `{}`                     |
| `server.tolerations`                      | Tolerations for Gorse server pods assignment                                                                                     | `[]`                     |
| `server.pdb.create`                       | Specifies whether a PodDisruptionBudget should be created                                                                        | `false`                  |
| `server.pdb.minAvailable`                 | Min number of pods that must still be available after the eviction                                                               | `1`                      |
| `server.pdb.maxUnavailable`               | Max number of pods that can be unavailable after the eviction                                                                    | `""`                     |

### Gorse worker node parameters

| Name                                      | Description                                                                                                  | Value                    |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------ |
| `worker.image.registry`                   | Gorse image registry                                                                                         | `docker.io`              |
| `worker.image.repository`                 | Gorse Worker image repository                                                                                | `zhenghaoz/gorse-worker` |
| `worker.image.tag`                        | Gorse Worker image tag (immutable tags are recommended)                                                      | `0.4.9`                  |
| `worker.image.digest`                     | Gorse Worker image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`                     |
| `worker.image.pullPolicy`                 | Gorse Worker image pull policy                                                                               | `IfNotPresent`           |
| `worker.image.pullSecrets`                | Specify docker-registry secret names as an array                                                             | `[]`                     |
| `worker.service.enable`                   | Enable service for Gorse workers                                                                             | `false`                  |
| `worker.service.type`                     | Gorse worker service type                                                                                    | `ClusterIP`              |
| `worker.service.ports.http`               | Gorse worker service port                                                                                    | `8087`                   |
| `worker.service.nodePorts.http`           | Node port for Gorse worker                                                                                   | `""`                     |
| `worker.service.externalTrafficPolicy`    | Gorse worker service external traffic policy                                                                 | `Cluster`                |
| `worker.service.extraPorts`               | Extra ports to expose (normally used with the `sidecar` value)                                               | `[]`                     |
| `worker.service.internalTrafficPolicy`    | Gorse worker service internal traffic policy (requires Kubernetes v1.22 or greater to be usable)             | `Cluster`                |
| `worker.service.clusterIP`                | Gorse worker service Cluster IP                                                                              | `""`                     |
| `worker.service.loadBalancerIP`           | Gorse worker service Load Balancer IP                                                                        | `""`                     |
| `worker.service.loadBalancerSourceRanges` | Gorse worker service Load Balancer sources                                                                   | `[]`                     |
| `worker.service.annotations`              | Additional custom annotations for Gorse worker service                                                       | `{}`                     |
| `worker.service.sessionAffinity`          | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                                         | `None`                   |
| `worker.service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                  | `{}`                     |
| `worker.autoscaling.enabled`              | Enable replica autoscaling settings                                                                          | `false`                  |
| `worker.autoscaling.minReplicas`          | Minimum replicas for the pod autoscaling                                                                     | `1`                      |
| `worker.autoscaling.maxReplicas`          | Maximum replicas for the pod autoscaling                                                                     | `11`                     |
| `worker.autoscaling.targetCPU`            | Percentage of CPU to consider when autoscaling                                                               | `""`                     |
| `worker.autoscaling.targetMemory`         | Percentage of Memory to consider when autoscaling                                                            | `""`                     |
| `worker.resources.limits`                 | The resources limits for the Gorse replicas containers                                                       | `{}`                     |
| `worker.resources.requests`               | The requested resources for the Gorse replicas containers                                                    | `{}`                     |
| `worker.podAffinityPreset`                | Pod affinity preset. Ignored if `worker.affinity` is set. Allowed values: `soft` or `hard`                   | `""`                     |
| `worker.podAntiAffinityPreset`            | Pod anti-affinity preset. Ignored if `worker.affinity` is set. Allowed values: `soft` or `hard`              | `soft`                   |
| `worker.nodeAffinityPreset.type`          | Node affinity preset type. Ignored if `worker.affinity` is set. Allowed values: `soft` or `hard`             | `""`                     |
| `worker.nodeAffinityPreset.key`           | Node label key to match. Ignored if `worker.affinity` is set                                                 | `""`                     |
| `worker.nodeAffinityPreset.values`        | Node label values to match. Ignored if `worker.affinity` is set                                              | `[]`                     |
| `worker.affinity`                         | Affinity for Gorse worker pods assignment                                                                    | `{}`                     |
| `worker.nodeSelector`                     | Node labels for Gorse worker pods assignment                                                                 | `{}`                     |
| `worker.tolerations`                      | Tolerations for Gorse worker pods assignment                                                                 | `[]`                     |
| `worker.pdb.create`                       | Specifies whether a PodDisruptionBudget should be created                                                    | `false`                  |
| `worker.pdb.minAvailable`                 | Min number of pods that must still be available after the eviction                                           | `1`                      |
| `worker.pdb.maxUnavailable`               | Max number of pods that can be unavailable after the eviction                                                | `""`                     |

### Redis&reg; Parameters

| Name                  | Description                                             | Value        |
| --------------------- | ------------------------------------------------------- | ------------ |
| `redis.enabled`       | Switch to enable or disable the PostgreSQL helm chart   | `false`      |
| `redis.auth.enabled`  | Name for a custom user to create                        | `true`       |
| `redis.auth.password` | Password for the custom user to create                  | `""`         |
| `redis.architecture`  | PostgreSQL architecture (`standalone` or `replication`) | `standalone` |

### Database Parameters

| Name                             | Description                                               | Value        |
| -------------------------------- | --------------------------------------------------------- | ------------ |
| `postgresql.enabled`             | Switch to enable or disable the PostgreSQL helm chart     | `false`      |
| `postgresql.auth.username`       | Name for a custom user to create                          | `gorse`      |
| `postgresql.auth.password`       | Password for the custom user to create                    | `""`         |
| `postgresql.auth.database`       | Name for a custom database to create                      | `gorse`      |
| `postgresql.auth.existingSecret` | Name of existing secret to use for PostgreSQL credentials | `""`         |
| `postgresql.architecture`        | PostgreSQL architecture (`standalone` or `replication`)   | `standalone` |

## Configuration

Additional configuration parameters for the Redis chart deployed with Gorse can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/redis).

Additional configuration parameters for the PostgreSQL chart deployed with Gorse can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/postgresql).

> **Tip**: You can use the default [values.yaml](values.yaml). this will auto generate some secrets.
