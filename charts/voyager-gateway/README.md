# voyager-gateway

The Helm chart for Voyager Gateway

**Homepage:** <https://gateway.voyagermesh.com/>

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

### Install from DockerHub

Once Helm has been set up correctly, install the chart from dockerhub:

``` shell
  helm install eg oci://ghcr.io/voyagermesh/voyager-gateway -n envoy-gateway-system --create-namespace
```

### Skip install CRDs

You can install the eg chart along without Gateway API CRDs and Voyager Gateway CRDs, make sure CRDs exist in Cluster first if you want to skip to install them, otherwise EG may fail to start:

``` shell
    helm install eg --create-namespace oci://ghcr.io/voyagermesh/voyager-gateway -n envoy-gateway-system --skip-crds
```

To uninstall the chart:

``` shell
    helm delete eg
```

## Values

| Key                                                | Type   | Default                                           | Description |
|----------------------------------------------------| ------ |---------------------------------------------------| ----------- |
| config.envoyGateway.gateway.controllerName         | string | `"gateway.voyagermesh.com/gatewayclass-controller"` |             |
| config.envoyGateway.provider.type                  | string | `"Kubernetes"`                                    |             |
| deployment.envoyGateway.image.repository           | string | `"docker.io/envoyproxy/gateway-dev"`              |             |
| deployment.envoyGateway.image.tag                  | string | `"latest"`                                        |             |
| deployment.envoyGateway.imagePullPolicy            | string | `"Always"`                                        |             |
| deployment.envoyGateway.resources.limits.cpu       | string | `"500m"`                                          |             |
| deployment.envoyGateway.resources.limits.memory    | string | `"128Mi"`                                         |             |
| deployment.envoyGateway.resources.requests.cpu     | string | `"10m"`                                           |             |
| deployment.envoyGateway.resources.requests.memory  | string | `"64Mi"`                                          |             |
| deployment.kubeRbacProxy.image.repository          | string | `"gcr.io/kubebuilder/kube-rbac-proxy"`            |             |
| deployment.kubeRbacProxy.image.tag                 | string | `"v0.11.0"`                                       |             |
| deployment.kubeRbacProxy.imagePullPolicy           | string | `"IfNotPresent"`                                  |             |
| deployment.kubeRbacProxy.resources.limits.cpu      | string | `"500m"`                                          |             |
| deployment.kubeRbacProxy.resources.limits.memory   | string | `"128Mi"`                                         |             |
| deployment.kubeRbacProxy.resources.requests.cpu    | string | `"5m"`                                            |             |
| deployment.kubeRbacProxy.resources.requests.memory | string | `"64Mi"`                                          |             |
| deployment.ports[0].name                           | string | `"grpc"`                                          |             |
| deployment.ports[0].port                           | int    | `18000`                                           |             |
| deployment.ports[0].targetPort                     | int    | `18000`                                           |             |
| deployment.ports[1].name                           | string | `"ratelimit"`                                     |             |
| deployment.ports[1].port                           | int    | `18001`                                           |             |
| deployment.ports[1].targetPort                     | int    | `18001`                                           |             |
| deployment.replicas                                | int    | `1`                                               |             |
| deployment.pod.annotations                         | object | `{}`                                              |             |
| deployment.pod.labels                              | object | `{}`                                              |             |
| envoyGatewayMetricsService.ports[0].name           | string | `"https"`                                         |             |
| envoyGatewayMetricsService.ports[0].port           | int    | `8443`                                            |             |
| envoyGatewayMetricsService.ports[0].protocol       | string | `"TCP"`                                           |             |
| envoyGatewayMetricsService.ports[0].targetPort     | string | `"https"`                                         |             |
| kubernetesClusterDomain                            | string | `"cluster.local"`                                 |             |
