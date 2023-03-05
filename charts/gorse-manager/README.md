# Gorse Manager Helm Chart

Gorse Manager provides a cloud native solution to browse, deploy and manage the lifecycle of Gorse instances on a Kubernetes cluster.

## Install

This following steps walk you through the process of deploying Gorse Manager for your cluster.

### Step 1: Install Gorse Manager

Use the official Gorse Manager chart to install the latest version:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add gorse-io https://charts.gorse.io
helm upgrade --name my-release \
  --namespace gorse --create-namespace \
  --install gorse-io/gorse-manager --devel
```

For detailed information on installing, configuring and upgrading Gorse Manager, check out the [chart README](https://github.com/gorse-io/charts/tree/main/charts/gorse-manager).

The above commands deploy Gorse Manager into the gorse namespace in your cluster. It may take a few minutes to run. Once it has been deployed and the Gorse Manager pods are running, continue to step 2.

### Step 2: Create a Demo Credential to Access Kubernetes

To try out Gorse Manager for personal learning, we can create a Kubernetes service account and use that API token to authenticate with the Kubernetes API server via Gorse Manager:

```bash
kubectl create --namespace default serviceaccount gorse-manager
kubectl create clusterrolebinding gorse-manager \
  --clusterrole=cluster-admin \
  --serviceaccount=default:gorse-manager
```

### Step 3: Start the Gorse Manager Dashboard

Once Gorse Manager is installed, securely access the Gorse Manager Dashboard from your system by running:

```bash
kubectl port-forward -n gorse svc/gorse-manager 8888:8888
```

This starts an HTTP proxy for secure access to the Gorse Manager Dashboard. Visit http://127.0.0.1:8888/ in your preferred web browser to open the Dashboard.

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


### Gorse Manager Configuration

| Name                               | Description                                                                                                                      | Value                     |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| `database`                         | URI used to connect Gorse manager to the database for user data.                                                                 | `""`                      |
| `service.type`                     | Gorse Manager service type                                                                                                       | `ClusterIP`               |
| `service.ports.http`               | Gorse Manager service HTTP port                                                                                                  | `80`                      |
| `service.ports.https`              | Gorse Manager service HTTPS port                                                                                                 | `443`                     |
| `service.httpsTargetPort`          | Target port for HTTPS                                                                                                            | `https`                   |
| `service.nodePorts.http`           | Node port for HTTP                                                                                                               | `""`                      |
| `service.nodePorts.https`          | Node port for HTTPS                                                                                                              | `""`                      |
| `service.sessionAffinity`          | Control where client requests go, to the same pod or round-robin                                                                 | `None`                    |
| `service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                                      | `{}`                      |
| `service.clusterIP`                | Gorse Manager service Cluster IP                                                                                                 | `""`                      |
| `service.loadBalancerIP`           | Gorse Manager service Load Balancer IP                                                                                           | `""`                      |
| `service.loadBalancerSourceRanges` | Gorse Manager service Load Balancer sources                                                                                      | `[]`                      |
| `service.externalTrafficPolicy`    | Gorse Manager service external traffic policy                                                                                    | `Cluster`                 |
| `service.annotations`              | Additional custom annotations for Gorse Manager service                                                                          | `{}`                      |
| `service.extraPorts`               | Extra port to expose on Gorse Manager service                                                                                    | `[]`                      |
| `ingress.enabled`                  | Enable ingress record generation for Gorse Manager                                                                               | `false`                   |
| `ingress.pathType`                 | Ingress path type                                                                                                                | `ImplementationSpecific`  |
| `ingress.apiVersion`               | Force Ingress API version (automatically detected if not set)                                                                    | `""`                      |
| `ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                      |
| `ingress.hostname`                 | Default host for the ingress record                                                                                              | `gorse-manager.local`     |
| `ingress.path`                     | Default path for the ingress record                                                                                              | `/`                       |
| `ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                      |
| `ingress.tls`                      | Enable TLS configuration for the host defined at `ingress.hostname` parameter                                                    | `false`                   |
| `ingress.tlsWwwPrefix`             | Adds www subdomain to default cert                                                                                               | `false`                   |
| `ingress.selfSigned`               | Create a TLS secret for this ingress record using self-signed certificates generated by Helm                                     | `false`                   |
| `ingress.extraHosts`               | An array with additional hostname(s) to be covered with the ingress record                                                       | `[]`                      |
| `ingress.extraPaths`               | An array with additional arbitrary paths that may need to be added to the ingress under the main host                            | `[]`                      |
| `ingress.extraTls`                 | TLS configuration for additional hostname(s) to be covered with this ingress record                                              | `[]`                      |
| `ingress.secrets`                  | Custom TLS certificates as secrets                                                                                               | `[]`                      |
| `ingress.extraRules`               | Additional rules to be covered with this ingress record                                                                          | `[]`                      |
| `image.registry`                   | Gorse image registry                                                                                                             | `docker.io`               |
| `image.repository`                 | Gorse Manager image repository                                                                                                   | `zhenghaoz/gorse-manager` |
| `image.tag`                        | Gorse Manager image tag (immutable tags are recommended)                                                                         | `nightly`                 |
| `image.digest`                     | Gorse Manager image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag                    | `""`                      |
| `image.pullPolicy`                 | Gorse Manager image pull policy                                                                                                  | `IfNotPresent`            |
| `image.pullSecrets`                | Specify docker-registry secret names as an array                                                                                 | `[]`                      |
| `podAffinityPreset`                | Pod affinity preset. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`                                       | `""`                      |
| `podAntiAffinityPreset`            | Pod anti-affinity preset. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`                                  | `soft`                    |
| `nodeAffinityPreset.type`          | Node affinity preset type. Ignored if `server.affinity` is set. Allowed values: `soft` or `hard`                                 | `""`                      |
| `nodeAffinityPreset.key`           | Node label key to match. Ignored if `server.affinity` is set                                                                     | `""`                      |
| `nodeAffinityPreset.values`        | Node label values to match. Ignored if `server.affinity` is set                                                                  | `[]`                      |
| `affinity`                         | Affinity for Gorse server pods assignment                                                                                        | `{}`                      |
| `nodeSelector`                     | Node labels for Gorse server pods assignment                                                                                     | `{}`                      |
| `tolerations`                      | Tolerations for Gorse server pods assignment                                                                                     | `[]`                      |


### Other Parameters

| Name                                          | Description                                                            | Value   |
| --------------------------------------------- | ---------------------------------------------------------------------- | ------- |
| `serviceAccount.create`                       | Enable creation of ServiceAccount for Gorse Manager pod                | `false` |
| `serviceAccount.name`                         | The name of the ServiceAccount to use.                                 | `""`    |
| `serviceAccount.automountServiceAccountToken` | Allows auto mount of ServiceAccountToken on the serviceAccount created | `true`  |
| `serviceAccount.annotations`                  | Additional custom annotations for the ServiceAccount                   | `{}`    |


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


### MySQL Parameters

| Name                      | Description                                                        | Value   |
| ------------------------- | ------------------------------------------------------------------ | ------- |
| `mysql.enabled`           | Switch to enable or disable the MySQL helm chart                   | `true`  |
| `mysql.auth.rootPassword` | Password for the root user. Ignored if existing secret is provided | `""`    |
| `mysql.auth.database`     | Name for a custom database to create                               | `gorse` |
| `mysql.auth.username`     | Name for a custom user to create                                   | `""`    |
| `mysql.auth.password`     | Password for the new user. Ignored if existing secret is provided  | `""`    |

