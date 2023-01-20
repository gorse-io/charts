# Gorse Manager Helm Chart

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


### Gorse Manager Configuration

| Name                               | Description                                                                                                   | Value                     |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------- |
| `database`                         | URI used to connect Gorse manager to the database for user data.                                              | `""`                      |
| `service.type`                     | WordPress service type                                                                                        | `NodePort`                |
| `service.ports.http`               | WordPress service HTTP port                                                                                   | `8888`                    |
| `service.nodePorts.http`           | Node port for HTTP                                                                                            | `""`                      |
| `service.sessionAffinity`          | Control where client requests go, to the same pod or round-robin                                              | `None`                    |
| `service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                   | `{}`                      |
| `service.clusterIP`                | WordPress service Cluster IP                                                                                  | `""`                      |
| `service.loadBalancerIP`           | WordPress service Load Balancer IP                                                                            | `""`                      |
| `service.loadBalancerSourceRanges` | WordPress service Load Balancer sources                                                                       | `[]`                      |
| `service.externalTrafficPolicy`    | WordPress service external traffic policy                                                                     | `Cluster`                 |
| `service.annotations`              | Additional custom annotations for WordPress service                                                           | `{}`                      |
| `service.extraPorts`               | Extra port to expose on WordPress service                                                                     | `[]`                      |
| `image.registry`                   | Gorse image registry                                                                                          | `docker.io`               |
| `image.repository`                 | Gorse Manager image repository                                                                                | `zhenghaoz/gorse-manager` |
| `image.tag`                        | Gorse Manager image tag (immutable tags are recommended)                                                      | `nightly`                 |
| `image.digest`                     | Gorse Manager image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`                      |
| `image.pullPolicy`                 | Gorse Manager image pull policy                                                                               | `IfNotPresent`            |
| `image.pullSecrets`                | Specify docker-registry secret names as an array                                                              | `[]`                      |
| `autoscaling.enabled`              | Enable replica autoscaling settings                                                                           | `false`                   |
| `autoscaling.minReplicas`          | Minimum replicas for the pod autoscaling                                                                      | `1`                       |
| `autoscaling.maxReplicas`          | Maximum replicas for the pod autoscaling                                                                      | `11`                      |
| `autoscaling.targetCPU`            | Percentage of CPU to consider when autoscaling                                                                | `""`                      |
| `autoscaling.targetMemory`         | Percentage of Memory to consider when autoscaling                                                             | `""`                      |
| `podAffinityPreset`                | Pod affinity preset. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`                    | `""`                      |
| `podAntiAffinityPreset`            | Pod anti-affinity preset. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`               | `soft`                    |
| `nodeAffinityPreset.type`          | Node affinity preset type. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`              | `""`                      |
| `nodeAffinityPreset.key`           | Node label key to match. Ignored if `server.affinity` is set                                                  | `""`                      |
| `nodeAffinityPreset.values`        | Node label values to match. Ignored if `server.affinity` is set                                               | `[]`                      |
| `affinity`                         | Affinity for Gorse server pods assignment                                                                     | `{}`                      |
| `nodeSelector`                     | Node labels for Gorse server pods assignment                                                                  | `{}`                      |
| `tolerations`                      | Tolerations for Gorse server pods assignment                                                                  | `[]`                      |


### MongoDB&reg; Parameters

| Name                        | Description                                             | Value        |
| --------------------------- | ------------------------------------------------------- | ------------ |
| `mongodb.enabled`           | Switch to enable or disable the MongoDB helm chart      | `true`       |
| `mongodb.auth.enabled`      | Enable authentication                                   | `false`      |
| `mongodb.auth.rootPassword` | MongoDB(®) root password                                | `""`         |
| `mongodb.architecture`      | MongoDB(®) architecture (`standalone`` or `replicaset`) | `standalone` |
