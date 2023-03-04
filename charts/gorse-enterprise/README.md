# Gorse Enterprise Helm Chart

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


### Gorse Configuration parameters

| Name                                                | Description                                                                   | Value        |
| --------------------------------------------------- | ----------------------------------------------------------------------------- | ------------ |
| `gorse.dashboard.username`                          | Username for the dashboard.                                                   | `gorse`      |
| `gorse.dashboard.password`                          | Password for the dashboard.                                                   | `""`         |
| `gorse.dashboard.authServer`                        | Token server for the dashboard.                                               | `""`         |
| `gorse.api.key`                                     | The key to secure the API endpoint                                            | `""`         |
| `gorse.api.corsDomains`                             | List of allowed values for Http Origin                                        | `[]`         |
| `gorse.api.corsMethods`                             | List of http methods names. Checking is case-insensitive.                     | `[]`         |
| `gorse.api.autoInsertUsers`                         | Insert new users while inserting feedback                                     | `true`       |
| `gorse.api.autoInsertItems`                         | Insert new items while inserting feedback.                                    | `true`       |
| `gorse.api.returnSize`                              | Default number of returned items                                              | `10`         |
| `gorse.api.serverCacheExpire`                       | Server-side cache expire time                                                 | `10s`        |
| `gorse.recommends[0].name`                          | The name of recommend channel                                                 | `default`    |
| `gorse.recommends[0].dataSource.feedbackTimeToLive` | The time-to-live (days) of positive feedback                                  | `0`          |
| `gorse.recommends[0].dataSource.itemTimeToLive`     | The time-to-live (days) of items                                              | `0`          |
| `gorse.recommends[0].dataSource.positiveFeedbacks`  | The feedback types for positive events                                        | `[]`         |
| `gorse.recommends[0].dataSource.readFeedbacks`      | The feedback types for read events.                                           | `[]`         |
| `gorse.recommends[0].cache.size`                    | The cache size for recommended/popular/latest items                           | `10`         |
| `gorse.recommends[0].cache.expire`                  | Recommended cache expire time                                                 | `72h`        |
| `gorse.recommends[0].popular`                       | The time window of popular items                                              | `4320h`      |
| `gorse.recommends[0].neighbors.users.type`          | The type of neighbors for users                                               | `similar`    |
| `gorse.recommends[0].neighbors.items.type`          | The type of neighbors for items.                                              | `similar`    |
| `gorse.recommends[0].collaborative.enable`          | Enable approximate collaborative filtering recommend using vector index       | `true`       |
| `gorse.recommends[0].replacement.enable`            | Replace historical items back to recommendations                              | `false`      |
| `gorse.recommends[0].replacement.decay.positive`    | Decay the weights of replaced items from positive feedbacks                   | `0.8`        |
| `gorse.recommends[0].replacement.decay.read`        | Decay the weights of replaced items from read feedbacks                       | `0.6`        |
| `gorse.recommends[0].online.fallback`               | The fallback recommendation method is used when cached recommendation drained | `["latest"]` |


### Gorse master node parameters

| Name                                      | Description                                                                                                                      | Value                    |
| ----------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| `master.jobs`                             | Number of working jobs in the master node                                                                                        | `1`                      |
| `master.image.registry`                   | Gorse image registry                                                                                                             | `docker.io`              |
| `master.image.repository`                 | Gorse Master image repository                                                                                                    | `zhenghaoz/gorse-master` |
| `master.image.tag`                        | Gorse Master image tag (immutable tags are recommended)                                                                          | `0.4.12`                 |
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
| `master.ingress.path`                     | The Path to Gorse. You may need to set this to '/*' in order to use this                                                         | `/`                      |
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
| `server.image.tag`                        | Gorse Server image tag (immutable tags are recommended)                                                                          | `0.4.12`                 |
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
| `worker.image.tag`                        | Gorse Worker image tag (immutable tags are recommended)                                                      | `0.4.12`                 |
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


### Gorse proxy parameters

| Name                                     | Description                                                                                                  | Value                   |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ----------------------- |
| `proxy.image.registry`                   | Gorse image registry                                                                                         | `docker.io`             |
| `proxy.image.repository`                 | Gorse Worker image repository                                                                                | `zhenghaoz/gorse-proxy` |
| `proxy.image.tag`                        | Gorse Worker image tag (immutable tags are recommended)                                                      | `0.4.0`                 |
| `proxy.image.digest`                     | Gorse Worker image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`                    |
| `proxy.image.pullPolicy`                 | Gorse Worker image pull policy                                                                               | `IfNotPresent`          |
| `proxy.image.pullSecrets`                | Specify docker-registry secret names as an array                                                             | `[]`                    |
| `proxy.service.enable`                   | Enable service for Gorse proxies                                                                             | `false`                 |
| `proxy.service.type`                     | Gorse worker service type                                                                                    | `ClusterIP`             |
| `proxy.service.ports.http`               | Gorse worker service port                                                                                    | `9000`                  |
| `proxy.service.nodePorts.http`           | Node port for Gorse proxy                                                                                    | `""`                    |
| `proxy.service.externalTrafficPolicy`    | Gorse proxy service external traffic policy                                                                  | `Cluster`               |
| `proxy.service.extraPorts`               | Extra ports to expose (normally used with the `sidecar` value)                                               | `[]`                    |
| `proxy.service.internalTrafficPolicy`    | Gorse proxy service internal traffic policy (requires Kubernetes v1.22 or greater to be usable)              | `Cluster`               |
| `proxy.service.clusterIP`                | Gorse proxy service Cluster IP                                                                               | `""`                    |
| `proxy.service.loadBalancerIP`           | Gorse proxy service Load Balancer IP                                                                         | `""`                    |
| `proxy.service.loadBalancerSourceRanges` | Gorse proxy service Load Balancer sources                                                                    | `[]`                    |
| `proxy.service.annotations`              | Additional custom annotations for Gorse proxy service                                                        | `{}`                    |
| `proxy.service.sessionAffinity`          | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                                         | `None`                  |
| `proxy.service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                  | `{}`                    |
| `proxy.replicaCount`                     | Number of proxies replicas to deploy                                                                         | `1`                     |
| `proxy.autoscaling.enabled`              | Enable replica autoscaling settings                                                                          | `false`                 |
| `proxy.autoscaling.minReplicas`          | Minimum replicas for the pod autoscaling                                                                     | `1`                     |
| `proxy.autoscaling.maxReplicas`          | Maximum replicas for the pod autoscaling                                                                     | `11`                    |
| `proxy.autoscaling.targetCPU`            | Percentage of CPU to consider when autoscaling                                                               | `50`                    |
| `proxy.autoscaling.targetMemory`         | Percentage of Memory to consider when autoscaling                                                            | `50`                    |
| `proxy.resources.limits`                 | The resources limits for the Gorse replicas containers                                                       | `{}`                    |
| `proxy.resources.requests`               | The requested resources for the Gorse replicas containers                                                    | `{}`                    |
| `proxy.podAffinityPreset`                | Pod affinity preset. Ignored if `proxy.affinity` is set. Allowed values: `soft` or `hard`                    | `""`                    |
| `proxy.podAntiAffinityPreset`            | Pod anti-affinity preset. Ignored if `proxy.affinity` is set. Allowed values: `soft` or `hard`               | `soft`                  |
| `proxy.nodeAffinityPreset.type`          | Node affinity preset type. Ignored if `proxy.affinity` is set. Allowed values: `soft` or `hard`              | `""`                    |
| `proxy.nodeAffinityPreset.key`           | Node label key to match. Ignored if `proxy.affinity` is set                                                  | `""`                    |
| `proxy.nodeAffinityPreset.values`        | Node label values to match. Ignored if `proxy.affinity` is set                                               | `[]`                    |
| `proxy.affinity`                         | Affinity for Gorse proxy pods assignment                                                                     | `{}`                    |
| `proxy.nodeSelector`                     | Node labels for Gorse proxy pods assignment                                                                  | `{}`                    |
| `proxy.tolerations`                      | Tolerations for Gorse proxy pods assignment                                                                  | `[]`                    |
| `proxy.pdb.create`                       | Specifies whether a PodDisruptionBudget should be created                                                    | `false`                 |
| `proxy.pdb.minAvailable`                 | Min number of pods that must still be available after the eviction                                           | `1`                     |
| `proxy.pdb.maxUnavailable`               | Max number of pods that can be unavailable after the eviction                                                | `""`                    |


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

