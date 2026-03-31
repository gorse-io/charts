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

| Name           | Description                                                                  | Value         |
| -------------- | ---------------------------------------------------------------------------- | ------------- |
| `architecture` | Gorse deployment architecture. Allowed values: `standalone` or `distributed` | `distributed` |

### Gorse Configuration parameters

| Name                         | Description                     | Value   |
| ---------------------------- | ------------------------------- | ------- |
| `gorse.dashboard.username`   | Username for the dashboard.     | `gorse` |
| `gorse.dashboard.password`   | Password for the dashboard.     | `""`    |
| `gorse.dashboard.authServer` | Token server for the dashboard. | `""`    |

### Master SSL

| Name                               | Description                                               | Value                       |
| ---------------------------------- | --------------------------------------------------------- | --------------------------- |
| `gorse.master.ssl.mode`            | Enable SSL for the gRPC communication.                    | `false`                     |
| `gorse.master.ssl.ca`              | SSL certification authority for the gRPC communication.   | `""`                        |
| `gorse.master.ssl.cert`            | SSL certification for the gRPC communication.             | `""`                        |
| `gorse.master.ssl.key`             | SSL certification key for the gRPC communication.         | `""`                        |
| `gorse.api.key`                    | The key to secure the API endpoint                        | `""`                        |
| `gorse.api.corsDomains`            | List of allowed values for Http Origin                    | `[]`                        |
| `gorse.api.corsMethods`            | List of http methods names. Checking is case-insensitive. | `[]`                        |
| `gorse.api.autoInsertUsers`        | Insert new users while inserting feedback                 | `true`                      |
| `gorse.api.autoInsertItems`        | Insert new items while inserting feedback.                | `true`                      |
| `gorse.api.returnSize`             | Default number of returned items                          | `10`                        |
| `gorse.api.serverCacheExpire`      | Server-side cache expire time                             | `10s`                       |
| `gorse.recommend`                  | TOML string for recommend configuration                   | `""`                        |
| `gorse.openai.baseUrl`             | Base URL of OpenAI API / Ollama                           | `http://localhost:11434/v1` |
| `gorse.openai.authToken`           | API key of OpenAI API                                     | `""`                        |
| `gorse.openai.chatCompletionModel` | Name of chat completion model                             | `qwen2.5`                   |
| `gorse.openai.chatCompletionRpm`   | Maximum requests per minute for chat completion           | `15000`                     |
| `gorse.openai.chatCompletionTpm`   | Maximum tokens per minute for chat completion             | `1200000`                   |
| `gorse.openai.embeddingModel`      | Name of embedding model                                   | `mxbai-embed-large`         |
| `gorse.openai.embeddingDimensions` | Dimensions of embedding vectors                           | `1024`                      |
| `gorse.openai.embeddingRpm`        | Maximum requests per minute for embedding                 | `1800`                      |
| `gorse.openai.embeddingTpm`        | Maximum tokens per minute for embedding                   | `1200000`                   |
| `gorse.openai.logFile`             | Log file for OpenAI API                                   | `openai.log`                |

### OIDC configuration

| Name                      | Description                          | Value   |
| ------------------------- | ------------------------------------ | ------- |
| `gorse.oidc.enable`       | Enable OpenID Connect authentication | `false` |
| `gorse.oidc.issuer`       | OAuth provider issuer                | `""`    |
| `gorse.oidc.clientId`     | OAuth application client ID          | `""`    |
| `gorse.oidc.clientSecret` | OAuth application client secret      | `""`    |
| `gorse.oidc.redirectUrl`  | OAuth redirect/callback URL          | `""`    |

### Tracing configuration

| Name                              | Description                                 | Value                              |
| --------------------------------- | ------------------------------------------- | ---------------------------------- |
| `gorse.tracing.enable`            | Enable tracing for REST APIs                | `false`                            |
| `gorse.tracing.exporter`          | Tracing exporter type (zipkin\|otlp\|otlphttp) | `otlphttp`                      |
| `gorse.tracing.collectorEndpoint` | Tracing collector endpoint                  | `http://localhost:4318/v1/traces` |
| `gorse.tracing.sampler`           | Tracing sampler type (always\|never\|ratio) | `always`                           |
| `gorse.tracing.ratio`             | Ratio used when sampler is set to ratio     | `1`                                |

### Gorse master node parameters


### Gorse standalone (gorse-in-one) parameters

| Name                                                         | Description                                                                                                                      | Value                    |
| ------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `standalone.image.registry`                                  | Gorse-in-one image registry                                                                                                      | `docker.io`              |
| `standalone.image.repository`                                | Gorse-in-one image repository                                                                                                    | `zhenghaoz/gorse-in-one` |
| `standalone.image.tag`                                       | Gorse-in-one image tag (immutable tags are recommended)                                                                          | `nightly`                |
| `standalone.image.digest`                                    | Gorse-in-one image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag                     | `""`                     |
| `standalone.image.pullPolicy`                                | Gorse-in-one image pull policy                                                                                                   | `IfNotPresent`           |
| `standalone.image.pullSecrets`                               | Specify docker-registry secret names as an array                                                                                 | `[]`                     |
| `standalone.kind`                                            | Use either Deployment or StatefulSet (default)                                                                                   | `StatefulSet`            |
| `standalone.replicaCount`                                    | Number of gorse-in-one replicas (should be 1 for standalone)                                                                     | `1`                      |
| `standalone.persistence.enabled`                             | Enable persistence using Persistent Volume Claims                                                                                | `true`                   |
| `standalone.persistence.medium`                              | Provide a medium for `emptyDir` volumes.                                                                                         | `""`                     |
| `standalone.persistence.sizeLimit`                           | Set this to enable a size limit for `emptyDir` volumes.                                                                          | `""`                     |
| `standalone.persistence.path`                                | The path the volume will be mounted at                                                                                           | `/var/lib/gorse`         |
| `standalone.persistence.subPath`                             | The subdirectory of the volume to mount                                                                                          | `""`                     |
| `standalone.persistence.storageClass`                        | Persistent Volume storage class                                                                                                  | `""`                     |
| `standalone.persistence.accessModes`                         | Persistent Volume access modes                                                                                                   | `["ReadWriteOnce"]`      |
| `standalone.persistence.size`                                | Persistent Volume size                                                                                                           | `1Gi`                    |
| `standalone.service.type`                                    | Kubernetes Service type                                                                                                          | `ClusterIP`              |
| `standalone.service.ports.http`                              | Gorse-in-one HTTP service port                                                                                                   | `8087`                   |
| `standalone.service.nodePorts.http`                          | HTTP node port (only used when service.type is NodePort or LoadBalancer)                                                         | `""`                     |
| `standalone.service.clusterIP`                               | Gorse-in-one service Cluster IP                                                                                                  | `""`                     |
| `standalone.service.loadBalancerIP`                          | Gorse-in-one service Load Balancer IP                                                                                            | `""`                     |
| `standalone.service.loadBalancerSourceRanges`                | Gorse-in-one service Load Balancer sources                                                                                       | `[]`                     |
| `standalone.service.externalTrafficPolicy`                   | Gorse-in-one service external traffic policy                                                                                     | `Cluster`                |
| `standalone.service.annotations`                             | Additional custom annotations for Gorse-in-one service                                                                           | `{}`                     |
| `standalone.resources.limits`                                | The resources limits for the gorse-in-one containers                                                                             | `{}`                     |
| `standalone.resources.requests`                              | The requested resources for the gorse-in-one containers                                                                          | `{}`                     |
| `standalone.livenessProbe.enabled`                           | Enable livenessProbe on gorse-in-one nodes                                                                                       | `true`                   |
| `standalone.livenessProbe.initialDelaySeconds`               | Initial delay seconds for livenessProbe                                                                                          | `5`                      |
| `standalone.livenessProbe.periodSeconds`                     | Period seconds for livenessProbe                                                                                                 | `10`                     |
| `standalone.livenessProbe.timeoutSeconds`                    | Timeout seconds for livenessProbe                                                                                                | `5`                      |
| `standalone.livenessProbe.failureThreshold`                  | Failure threshold for livenessProbe                                                                                              | `5`                      |
| `standalone.livenessProbe.successThreshold`                  | Success threshold for livenessProbe                                                                                              | `1`                      |
| `standalone.readinessProbe.enabled`                          | Enable readinessProbe on gorse-in-one nodes                                                                                      | `true`                   |
| `standalone.readinessProbe.initialDelaySeconds`              | Initial delay seconds for readinessProbe                                                                                         | `5`                      |
| `standalone.readinessProbe.periodSeconds`                    | Period seconds for readinessProbe                                                                                                | `10`                     |
| `standalone.readinessProbe.timeoutSeconds`                   | Timeout seconds for readinessProbe                                                                                               | `5`                      |
| `standalone.readinessProbe.failureThreshold`                 | Failure threshold for readinessProbe                                                                                             | `5`                      |
| `standalone.readinessProbe.successThreshold`                 | Success threshold for readinessProbe                                                                                             | `1`                      |
| `standalone.podAffinityPreset`                               | Pod affinity preset. Ignored if `standalone.affinity` is set. Allowed values: `soft` or `hard`                                   | `""`                     |
| `standalone.podAntiAffinityPreset`                           | Pod anti-affinity preset. Ignored if `standalone.affinity` is set. Allowed values: `soft` or `hard`                              | `soft`                   |
| `standalone.nodeAffinityPreset.type`                         | Node affinity preset type. Ignored if `standalone.affinity` is set. Allowed values: `soft` or `hard`                             | `""`                     |
| `standalone.nodeAffinityPreset.key`                          | Node label key to match. Ignored if `standalone.affinity` is set.                                                                | `""`                     |
| `standalone.nodeAffinityPreset.values`                       | Node label values to match. Ignored if `standalone.affinity` is set.                                                             | `[]`                     |
| `standalone.affinity`                                        | Affinity for gorse-in-one pods assignment                                                                                        | `{}`                     |
| `standalone.nodeSelector`                                    | Node labels for gorse-in-one pods assignment                                                                                     | `{}`                     |
| `standalone.tolerations`                                     | Tolerations for gorse-in-one pods assignment                                                                                     | `[]`                     |
| `standalone.podLabels`                                       | Extra labels for gorse-in-one pods                                                                                               | `{}`                     |
| `standalone.podAnnotations`                                  | Annotations for gorse-in-one pods                                                                                                | `{}`                     |
| `standalone.priorityClassName`                               | gorse-in-one pods' priorityClassName                                                                                             | `""`                     |
| `standalone.schedulerName`                                   | Name of the k8s scheduler (other than default)                                                                                   | `""`                     |
| `standalone.terminationGracePeriodSeconds`                   | Seconds Redmine pod needs to terminate gracefully                                                                                | `""`                     |
| `standalone.topologySpreadConstraints`                       | Topology Spread Constraints for pod assignment                                                                                   | `[]`                     |
| `standalone.podSecurityContextEnabled`                       | Enabled gorse-in-one pods' Security Context                                                                                      | `true`                   |
| `standalone.podSecurityContext.fsGroup`                      | Set gorse-in-one pod's Security Context fsGroup                                                                                  | `1001`                   |
| `standalone.containerSecurityContext.enabled`                | Enabled gorse-in-one containers' Security Context                                                                                | `true`                   |
| `standalone.containerSecurityContext.runAsUser`              | Set gorse-in-one containers' Security Context runAsUser                                                                          | `1001`                   |
| `standalone.containerSecurityContext.runAsNonRoot`           | Set gorse-in-one containers' Security Context runAsNonRoot                                                                       | `true`                   |
| `standalone.containerSecurityContext.readOnlyRootFilesystem` | Set gorse-in-one containers' Security Context readOnlyRootFilesystem                                                             | `false`                  |
| `standalone.command`                                         | Override default container command (useful when using custom images)                                                             | `[]`                     |
| `standalone.args`                                            | Override default container args (useful when using custom images)                                                                | `[]`                     |
| `standalone.hostAliases`                                     | gorse-in-one pods host aliases                                                                                                   | `[]`                     |
| `standalone.extraEnvVars`                                    | Array with extra environment variables to add to gorse-in-one nodes                                                              | `[]`                     |
| `standalone.extraEnvVarsCM`                                  | Name of existing ConfigMap containing extra env vars for gorse-in-one nodes                                                      | `""`                     |
| `standalone.extraEnvVarsSecret`                              | Name of existing Secret containing extra env vars for gorse-in-one nodes                                                         | `""`                     |
| `standalone.extraVolumes`                                    | Optionally specify extra list of additional volumes for the gorse-in-one pod(s)                                                  | `[]`                     |
| `standalone.extraVolumeMounts`                               | Optionally specify extra list of additional volumeMounts for the gorse-in-one container(s)                                       | `[]`                     |
| `standalone.sidecars`                                        | Add additional sidecar containers to the gorse-in-one pod(s)                                                                     | `[]`                     |
| `standalone.initContainers`                                  | Add additional init containers to the gorse-in-one pod(s)                                                                        | `[]`                     |
| `master.jobs`                                                | Number of working jobs in the master node                                                                                        | `1`                      |
| `master.image.registry`                                      | Gorse image registry                                                                                                             | `docker.io`              |
| `master.image.repository`                                    | Gorse Master image repository                                                                                                    | `zhenghaoz/gorse-master` |
| `master.image.tag`                                           | Gorse Master image tag (immutable tags are recommended)                                                                          | `nightly`                |
| `master.image.digest`                                        | Gorse Master image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag                     | `""`                     |
| `master.image.pullPolicy`                                    | Gorse Master image pull policy                                                                                                   | `IfNotPresent`           |
| `master.image.pullSecrets`                                   | Specify docker-registry secret names as an array                                                                                 | `[]`                     |
| `master.kind`                                                | Use either Deployment or StatefulSet (default)                                                                                   | `StatefulSet`            |
| `master.persistence.enabled`                                 | Enable persistence on Gorse master nodes using Persistent Volume Claims                                                          | `true`                   |
| `master.persistence.medium`                                  | Provide a medium for `emptyDir` volumes.                                                                                         | `""`                     |
| `master.persistence.sizeLimit`                               | Set this to enable a size limit for `emptyDir` volumes.                                                                          | `""`                     |
| `master.persistence.path`                                    | The path the volume will be mounted at on Gorse master containers                                                                | `/var/lib/gorse`         |
| `master.persistence.subPath`                                 | The subdirectory of the volume to mount on Gorse master containers                                                               | `""`                     |
| `master.persistence.subPathExpr`                             | Used to construct the subPath subdirectory of the volume to mount on Gorse master containers                                     | `""`                     |
| `master.persistence.storageClass`                            | Persistent Volume storage class                                                                                                  | `""`                     |
| `master.persistence.accessModes`                             | Persistent Volume access modes                                                                                                   | `["ReadWriteOnce"]`      |
| `master.persistence.size`                                    | Persistent Volume size                                                                                                           | `8Gi`                    |
| `master.persistence.annotations`                             | Additional custom annotations for the PVC                                                                                        | `{}`                     |
| `master.persistence.selector`                                | Additional labels to match for the PVC                                                                                           | `{}`                     |
| `master.persistence.dataSource`                              | Custom PVC data source                                                                                                           | `{}`                     |
| `master.persistence.existingClaim`                           | Use a existing PVC which must be created manually before bound                                                                   | `""`                     |
| `master.service.type`                                        | Gorse master service type                                                                                                        | `ClusterIP`              |
| `master.service.ports.http`                                  | HTTP port of the master node (dashboard)                                                                                         | `80`                     |
| `master.service.ports.grpc`                                  | GRPC port of the master node                                                                                                     | `8086`                   |
| `master.service.nodePorts.http`                              | HTTP port of the master node (dashboard)                                                                                         | `""`                     |
| `master.service.nodePorts.grpc`                              | GRPC port of the master node                                                                                                     | `""`                     |
| `master.service.externalTrafficPolicy`                       | Gorse master service external traffic policy                                                                                     | `Cluster`                |
| `master.service.extraPorts`                                  | Extra ports to expose (normally used with the `sidecar` value)                                                                   | `[]`                     |
| `master.service.internalTrafficPolicy`                       | Gorse master service internal traffic policy (requires Kubernetes v1.22 or greater to be usable)                                 | `Cluster`                |
| `master.service.clusterIP`                                   | Gorse master service Cluster IP                                                                                                  | `""`                     |
| `master.service.loadBalancerIP`                              | Gorse master service Load Balancer IP                                                                                            | `""`                     |
| `master.service.loadBalancerSourceRanges`                    | Gorse master service Load Balancer sources                                                                                       | `[]`                     |
| `master.service.annotations`                                 | Additional custom annotations for Gorse master service                                                                           | `{}`                     |
| `master.service.sessionAffinity`                             | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                                                             | `None`                   |
| `master.service.sessionAffinityConfig`                       | Additional settings for the sessionAffinity                                                                                      | `{}`                     |
| `master.ingress.enabled`                                     | Enable ingress controller resource                                                                                               | `false`                  |
| `master.ingress.pathType`                                    | Ingress Path type                                                                                                                | `ImplementationSpecific` |
| `master.ingress.apiVersion`                                  | Override API Version (automatically detected if not set)                                                                         | `""`                     |
| `master.ingress.ingressClassName`                            | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                     |
| `master.ingress.hostname`                                    | Default host for the ingress resource                                                                                            | `gorse.local`            |
| `master.ingress.path`                                        | The Path to Gorse. You may need to set this to '/*' in order to use this                                                         | `/`                      |
| `master.ingress.annotations`                                 | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                     |
| `master.ingress.tls`                                         | Enable TLS configuration for the hostname defined at ingress.hostname parameter                                                  | `false`                  |
| `master.ingress.extraHosts`                                  | The list of additional hostnames to be covered with this ingress record.                                                         | `[]`                     |
| `master.ingress.extraPaths`                                  | Any additional arbitrary paths that may need to be added to the ingress under the main host.                                     | `[]`                     |
| `master.ingress.extraTls`                                    | The tls configuration for additional hostnames to be covered with this ingress record.                                           | `[]`                     |
| `master.ingress.secrets`                                     | If you're providing your own certificates, please use this to add the certificates as secrets                                    | `[]`                     |
| `master.ingress.extraRules`                                  | Additional rules to be covered with this ingress record                                                                          | `[]`                     |
| `master.resources.limits`                                    | The resources limits for the Gorse replicas containers                                                                           | `{}`                     |
| `master.resources.requests`                                  | The requested resources for the Gorse replicas containers                                                                        | `{}`                     |
| `master.podAffinityPreset`                                   | Pod affinity preset. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`                                       | `""`                     |
| `master.podAntiAffinityPreset`                               | Pod anti-affinity preset. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`                                  | `soft`                   |
| `master.nodeAffinityPreset.type`                             | Node affinity preset type. Ignored if `master.affinity` is set. Allowed values: `soft` or `hard`                                 | `""`                     |
| `master.nodeAffinityPreset.key`                              | Node label key to match. Ignored if `master.affinity` is set                                                                     | `""`                     |
| `master.nodeAffinityPreset.values`                           | Node label values to match. Ignored if `master.affinity` is set                                                                  | `[]`                     |
| `master.affinity`                                            | Affinity for Gorse master pods assignment                                                                                        | `{}`                     |
| `master.nodeSelector`                                        | Node labels for Gorse master pods assignment                                                                                     | `{}`                     |
| `master.tolerations`                                         | Tolerations for Gorse master pods assignment                                                                                     | `[]`                     |
| `master.pdb.create`                                          | Specifies whether a PodDisruptionBudget should be created                                                                        | `false`                  |
| `master.pdb.minAvailable`                                    | Min number of pods that must still be available after the eviction                                                               | `1`                      |
| `master.pdb.maxUnavailable`                                  | Max number of pods that can be unavailable after the eviction                                                                    | `""`                     |

### Gorse server node parameters

| Name                                      | Description                                                                                                                      | Value                    |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `server.image.registry`                   | Gorse image registry                                                                                                             | `docker.io`              |
| `server.image.repository`                 | Gorse Server image repository                                                                                                    | `zhenghaoz/gorse-server` |
| `server.image.tag`                        | Gorse Server image tag (immutable tags are recommended)                                                                          | `nightly`                |
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
| `server.ingress.path`                     | The Path to Gorse. You may need to set this to '/*' in order to use this                                                         | `/`                      |
| `server.ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                     |
| `server.ingress.tls`                      | Enable TLS configuration for the hostname defined at ingress.hostname parameter                                                  | `false`                  |
| `server.ingress.extraHosts`               | The list of additional hostnames to be covered with this ingress record.                                                         | `[]`                     |
| `server.ingress.extraPaths`               | Any additional arbitrary paths that may need to be added to the ingress under the main host.                                     | `[]`                     |
| `server.ingress.extraTls`                 | The tls configuration for additional hostnames to be covered with this ingress record.                                           | `[]`                     |
| `server.ingress.secrets`                  | If you're providing your own certificates, please use this to add the certificates as secrets                                    | `[]`                     |
| `server.ingress.extraRules`               | Additional rules to be covered with this ingress record                                                                          | `[]`                     |
| `server.replicaCount`                     | Number of servers replicas to deploy                                                                                             | `1`                      |
| `server.autoscaling.enabled`              | Enable replica autoscaling settings                                                                                              | `false`                  |
| `server.autoscaling.minReplicas`          | Minimum replicas for the pod autoscaling                                                                                         | `1`                      |
| `server.autoscaling.maxReplicas`          | Maximum replicas for the pod autoscaling                                                                                         | `11`                     |
| `server.autoscaling.targetCPU`            | Percentage of CPU to consider when autoscaling                                                                                   | `50`                     |
| `server.autoscaling.targetMemory`         | Percentage of Memory to consider when autoscaling                                                                                | `50`                     |
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
| `worker.jobs`                             | Number of working jobs in the worker node                                                                    | `1`                      |
| `worker.image.registry`                   | Gorse image registry                                                                                         | `docker.io`              |
| `worker.image.repository`                 | Gorse Worker image repository                                                                                | `zhenghaoz/gorse-worker` |
| `worker.image.tag`                        | Gorse Worker image tag (immutable tags are recommended)                                                      | `nightly`                |
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
| `worker.replicaCount`                     | Number of workers replicas to deploy                                                                         | `1`                      |
| `worker.autoscaling.enabled`              | Enable replica autoscaling settings                                                                          | `false`                  |
| `worker.autoscaling.minReplicas`          | Minimum replicas for the pod autoscaling                                                                     | `1`                      |
| `worker.autoscaling.maxReplicas`          | Maximum replicas for the pod autoscaling                                                                     | `11`                     |
| `worker.autoscaling.targetCPU`            | Percentage of CPU to consider when autoscaling                                                               | `50`                     |
| `worker.autoscaling.targetMemory`         | Percentage of Memory to consider when autoscaling                                                            | `50`                     |
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

### Database Parameters

| Name                                         | Description                                                               | Value               |
| -------------------------------------------- | ------------------------------------------------------------------------- | ------------------- |
| `mongodb.enabled`                            | Deploy a MongoDB server to satisfy the applications database requirements | `true`              |
| `mongodb.architecture`                       | MongoDB(&reg;) architecture (`standalone` or `replicaset`)                | `standalone`        |
| `mongodb.auth.rootUser`                      | MongoDB(&reg;) root user                                                  | `root`              |
| `mongodb.auth.rootPassword`                  | MongoDB(&reg;) root password                                              | `""`                |
| `mongodb.auth.username`                      | Custom user to be created during the initialization                       | `gorse`             |
| `mongodb.auth.password`                      | Password for the custom users set at `auth.usernames`                     | `""`                |
| `mongodb.auth.database`                      | Custom databases to be created during the initialization                  | `gorse`             |
| `mongodb.persistence.enabled`                | Enable MongoDB(&reg;) data persistence using PVC                          | `true`              |
| `mongodb.persistence.storageClass`           | PVC Storage Class for MongoDB(&reg;) data volume                          | `""`                |
| `mongodb.persistence.accessModes`            | PV Access Mode                                                            | `["ReadWriteOnce"]` |
| `mongodb.persistence.size`                   | PVC Storage Request for MongoDB(&reg;) data volume                        | `8Gi`               |
| `externalDatabase.host`                      | Database host                                                             | `localhost`         |
| `externalDatabase.port`                      | Database port number                                                      | `27017`             |
| `externalDatabase.username`                  | Non-root username for Gorse                                               | `gorse`             |
| `externalDatabase.password`                  | Password for the non-root username for Gorse                              | `""`                |
| `externalDatabase.database`                  | Gorse database name                                                       | `gorse`             |
| `externalDatabase.existingSecret`            | Name of an existing secret resource containing the database credentials   | `""`                |
| `externalDatabase.existingSecretPasswordKey` | Name of an existing secret key containing the database credentials        | `mongodb-passwords` |
