# Gateway Converter

[Gateway Converter by AppsCode](https://github.com/voyagermesh) - Community features for Gateway by AppsCode

## TL;DR;

```bash
$ helm repo add appscode https://charts.appscode.com/stable/
$ helm repo update
$ helm search repo appscode/gateway-converter --version=v2024.8.30
$ helm upgrade -i gateway-converter appscode/gateway-converter -n voyagermesh --create-namespace --version=v2024.8.30
```

## Introduction

This chart deploys a Gateway Converter operator on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.25+

## Installing the Chart

To install/upgrade the chart with the release name `gateway-converter`:

```bash
$ helm upgrade -i gateway-converter appscode/gateway-converter -n voyagermesh --create-namespace --version=v2024.8.30
```

The command deploys a Gateway Converter operator on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall the `gateway-converter`:

```bash
$ helm uninstall gateway-converter -n voyagermesh
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the `gateway-converter` chart and their default values.

|            Parameter             |                                                                                                                Description                                                                                                                |                                                                                            Default                                                                                             |
|----------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| nameOverride                     | Overrides name template                                                                                                                                                                                                                   | <code>""</code>                                                                                                                                                                                |
| fullnameOverride                 | Overrides fullname template                                                                                                                                                                                                               | <code>""</code>                                                                                                                                                                                |
| replicaCount                     | Number of stash gateway converter replicas to create (only 1 is supported)                                                                                                                                                                | <code>1</code>                                                                                                                                                                                 |
| registryFQDN                     | Docker registry fqdn used to pull Stash related images. Set this to use docker registry hosted at ${registryFQDN}/${registry}/${image}                                                                                                    | <code>ghcr.io</code>                                                                                                                                                                           |
| server.registry                  | Docker registry used to pull gateway converter image                                                                                                                                                                                      | <code>voyagermesh</code>                                                                                                                                                                       |
| server.repository                | Name of gateway converter container image                                                                                                                                                                                                 | <code>gateway-converter</code>                                                                                                                                                                 |
| server.tag                       | Gateway converter container image tag                                                                                                                                                                                                     | <code>""</code>                                                                                                                                                                                |
| server.resources                 | Compute Resources required by the gateway converter container                                                                                                                                                                             | <code>{"requests":{"cpu":"100m"}}</code>                                                                                                                                                       |
| server.securityContext           | Security options this container should run with                                                                                                                                                                                           | <code>{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}</code> |
| imagePullSecrets                 | Specify an array of imagePullSecrets. Secrets must be manually created in the namespace. <br> Example: <br> `helm template charts/stash \` <br> `--set imagePullSecrets[0].name=sec0 \` <br> `--set imagePullSecrets[1].name=sec1`        | <code>[]</code>                                                                                                                                                                                |
| imagePullPolicy                  | Container image pull policy                                                                                                                                                                                                               | <code>IfNotPresent</code>                                                                                                                                                                      |
| criticalAddon                    | If true, installs Stash gateway converter as critical addon                                                                                                                                                                               | <code>false</code>                                                                                                                                                                             |
| logLevel                         | Log level for gateway converter                                                                                                                                                                                                           | <code>3</code>                                                                                                                                                                                 |
| annotations                      | Annotations applied to gateway converter deployment                                                                                                                                                                                       | <code>{}</code>                                                                                                                                                                                |
| podAnnotations                   | Annotations passed to gateway converter pod(s).                                                                                                                                                                                           | <code>{}</code>                                                                                                                                                                                |
| podLabels                        | Labels passed to gateway converter pod(s)                                                                                                                                                                                                 | <code>{}</code>                                                                                                                                                                                |
| nodeSelector                     | Node labels for pod assignment                                                                                                                                                                                                            | <code>{"kubernetes.io/os":"linux"}</code>                                                                                                                                                      |
| tolerations                      | Tolerations for pod assignment                                                                                                                                                                                                            | <code>[]</code>                                                                                                                                                                                |
| affinity                         | Affinity rules for pod assignment                                                                                                                                                                                                         | <code>{}</code>                                                                                                                                                                                |
| podSecurityContext               | Security options the gateway converter pod should run with.                                                                                                                                                                               | <code>{"fsGroup":65535}</code>                                                                                                                                                                 |
| serviceAccount.create            | Specifies whether a service account should be created                                                                                                                                                                                     | <code>true</code>                                                                                                                                                                              |
| serviceAccount.annotations       | Annotations to add to the service account                                                                                                                                                                                                 | <code>{}</code>                                                                                                                                                                                |
| serviceAccount.name              | The name of the service account to use. If not set and create is true, a name is generated using the fullname template                                                                                                                    | <code></code>                                                                                                                                                                                  |
| apiserver.healthcheck.enabled    | If true, enables the readiness and liveliness probes for the gateway converter pod.                                                                                                                                                       | <code>false</code>                                                                                                                                                                             |
| apiserver.servingCerts.generate  | If true, generates on install/upgrade the certs that allow the kube-apiserver (and potentially ServiceMonitor) to authenticate gateway converter pods. Otherwise specify certs in `apiserver.servingCerts.{caCrt, serverCrt, serverKey}`. | <code>true</code>                                                                                                                                                                              |
| apiserver.servingCerts.caCrt     | CA certficate used by serving certificate of webhook server.                                                                                                                                                                              | <code>""</code>                                                                                                                                                                                |
| apiserver.servingCerts.serverCrt | Serving certficate used by webhook server.                                                                                                                                                                                                | <code>""</code>                                                                                                                                                                                |
| apiserver.servingCerts.serverKey | Private key for the serving certificate used by webhook server.                                                                                                                                                                           | <code>""</code>                                                                                                                                                                                |
| hostNetwork                      | If true, uses HostNetwork for pods. This is required in EKS using Cilium with VxLAN overlay                                                                                                                                               | <code>false</code>                                                                                                                                                                             |
| monitoring.agent                 | Name of monitoring agent (either "prometheus.io/operator" or "prometheus.io/builtin")                                                                                                                                                     | <code>"none"</code>                                                                                                                                                                            |
| monitoring.serviceMonitor.labels | Specify the labels for ServiceMonitor. Prometheus crd will select ServiceMonitor using these labels. Only usable when monitoring agent is `prometheus.io/operator`.                                                                       | <code>{}</code>                                                                                                                                                                                |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm upgrade -i`. For example:

```bash
$ helm upgrade -i gateway-converter appscode/gateway-converter -n voyagermesh --create-namespace --version=v2024.8.30 --set replicaCount=1
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while
installing the chart. For example:

```bash
$ helm upgrade -i gateway-converter appscode/gateway-converter -n voyagermesh --create-namespace --version=v2024.8.30 --values values.yaml
```
