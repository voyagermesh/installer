[![Go Report Card](https://goreportcard.com/badge/github.com/appscode/voyager)](https://goreportcard.com/report/github.com/appscode/voyager)

[Website](https://appscode.com) • [Slack](https://slack.appscode.com) • [Twitter](https://twitter.com/AppsCodeHQ)

# voyager
Voyager is a [HAProxy](http://www.haproxy.org/) backed [secure](#certificate) L7 and L4 [ingress](#ingress) controller for Kubernetes developed by
[AppsCode](https://appscode.com). This can be used with any Kubernetes cloud providers including aws, gce, gke, azure, acs. This can also be used with bare metal Kubernetes clusters.


## Ingress
Voyager provides L7 and L4 loadbalancing using a custom Kubernetes [Ingress](/docs/tutorials/ingress) resource. This is built on top of the [HAProxy](http://www.haproxy.org/) to support high availability, sticky sessions, name and path-based virtual hosting.
This also support configurable application ports with all the options available in a standard Kubernetes [Ingress](https://kubernetes.io/docs/tutorials/ingress/). Here 
is a [complex ingress example](hack/example/ingress.yaml) that shows how various features can be used.
You can find the generated HAProxy Configuration [here](hack/example/haproxy_generated.cfg).

**Features**
  - [HTTP](/docs/tutorials/ingress/single-service.md) and [TCP](/docs/tutorials/ingress/tcp.md) loadbalancing,
  - [TLS Termination](/docs/tutorials/ingress/tls.md),
  - Multi-cloud support,
  - [Name and Path based virtual hosting](/docs/tutorials/ingress/named-virtual-hosting.md),
  - [Cross namespace routing support](/docs/tutorials/ingress/named-virtual-hosting.md#cross-namespace-traffic-routing),
  - [URL and Request Header Re-writing](/docs/tutorials/ingress/header-rewrite.md),
  - [Wildcard Name based virtual hosting](/docs/tutorials/ingress/named-virtual-hosting.md),
  - Persistent sessions, Loadbalancer stats.
  - [Route Traffic to StatefulSet Pods Based on Host Name](/docs/tutorials/ingress/statefulset-pod.md)
  - [Weighted Loadbalancing for Canary Deployment](/docs/tutorials/ingress/weighted.md)
  - [Customize generated HAProxy config via BackendRule](/docs/tutorials/ingress/backend-rule.md) (can be used for [http rewriting](https://www.haproxy.com/doc/aloha/7.0/haproxy/http_rewriting.html), add [health checks](https://www.haproxy.com/doc/aloha/7.0/haproxy/healthchecks.html), etc.)
  - [Add Custom Annotation to LoadBalancer Service and Pods](/docs/tutorials/ingress/annotations.md)
  - [Supports Loadbalancer Source Range](/docs/tutorials/ingress/source-range.md)
  - [Supports redirects/DNS resolution for `ExternalName` type service](/docs/tutorials/ingress/external-svc.md)
  - [Expose HAProxy stats for Prometheus](/docs/tutorials/ingress/stats-and-prometheus.md)
  - [Supports AWS certificate manager](/docs/tutorials/ingress/aws-cert-manager.md)
  - [Scale load balancer using HorizontalPodAutoscaling](/docs/tutorials/ingress/replicas-and-autoscaling.md)
  - [Configure Custom Timeouts for HAProxy](/docs/tutorials/ingress/configure-timeouts.md)
  - [Custom port for HTTP](/docs/tutorials/ingress/custom-http-port.md)
  - [Specify NodePort](/docs/tutorials/ingress/node-port.md)
  - [Backend TLS](/docs/tutorials/ingress/backend-tls.md)
  - [Configure Options](/docs/tutorials/ingress/configure-options.md)
  - [Using Custom HAProxy Templates](/docs/tutorials/ingress/custom-templates.md)
  - [Configure Basic Auth for HTTP Backends](/docs/tutorials/ingress/basic-auth.md)
  - [Configure Sticky session to Backends](/docs/tutorials/ingress/sticky-session.md)
  - [Apply Frontend Rules](/docs/tutorials/ingress/frontend-rule.md)
  - [Supported Annotations](/docs/tutorials/ingress/ingress-annotations.md)


### Comparison with Kubernetes
| Feauture | [Kube Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) | AppsCode Ingress |
|----------|--------------|------------------|
| HTTP Loadbalancing| :white_check_mark: | :white_check_mark: |
| TCP Loadbalancing | :x: | :white_check_mark: |
| TLS Termination | :white_check_mark: | :white_check_mark: |
| Name and Path based virtual hosting | :x: | :white_check_mark: |
| Cross Namespace service support | :x: | :white_check_mark: |
| URL and Header rewriting | :x: | :white_check_mark: |
| Wildcard name virtual hosting | :x: | :white_check_mark: |
| Loadbalancer statistics | :x: | :white_check_mark: |
| Route Traffic to StatefulSet Pods Based on Host Name | :x: | :white_check_mark: |
| Weighted Loadbalancing for Canary Deployment| :x: | :white_check_mark: |
| Supports Loadbalancer Source Range | :x: | :white_check_mark: |
| Supports redirects/DNS resolve for `ExternalName` type service | :x: | :white_check_mark: |
| Expose HAProxy stats for Prometheus | :x: | :white_check_mark: |
| Supports AWS certificate manager | :x: | :white_check_mark: |

## Certificate
Voyager can automaticallty provision and refresh SSL certificates issued from Let's Encrypt using a custom Kubernetes [Certificate](/docs/tutorials/certificate) resource.

**Features**
- Provision free TLS certificates from Let's Encrypt,
- Manage issued certificates using a Kubernetes Third Party Resource,
- Domain validation using ACME dns-01 challenges,
- Support for multiple DNS providers,
- Auto Renew Certificates,
- Use issued Certificates with Ingress to Secure Communications.

## Supported Versions
Please pick a version of Voyager that matches your Kubernetes installation.

| Voyager Version                                                                        | Docs                                                                    | Kubernetes Version | Prometheus operator Version |
|----------------------------------------------------------------------------------------|-------------------------------------------------------------------------|--------------------|-----------------------------|
| [5.0.0-rc.6](https://github.com/appscode/voyager/releases/tag/5.0.0-rc.6) (uses CRD) | [User Guide](https://github.com/appscode/voyager/tree/5.0.0-rc.6/docs) | 1.7.x+             | 0.12.0+                     |
| [3.2.2](https://github.com/appscode/voyager/releases/tag/3.2.2) (uses TPR)             | [User Guide](https://github.com/appscode/voyager/tree/3.2.2/docs)       | 1.5.x - 1.7.x      | < 0.12.0                    |


## User Guide
To deploy voyager in Kubernetes follow this [guide](/docs/install.md). In short this contains those two steps

1. Create `ingress.voyager.appscode.com` and `certificate.voyager.appscode.com` Third Party Resource
2. Deploy voyager to kubernetes.

## Running voyager alongside with other ingress controller
Voyager can be configured to handle default kubernetes ingress or only ingress.appscode.com. voyager can also be run
along side with other controllers.

```console
  --ingress-class
  // this flag can be set to 'voyager' to handle only ingress
  // with annotation kubernetes.io/ingress.class=voyager.

  // If unset, voyager will also handle ingress without ingress-class annotation.
```

## Developer Guide
Want to learn whats happening under the hood, read [the developer guide](/docs/developer-guide/README.md).

## Contribution
If you're interested in being a contributor, read [the contribution guide](CONTRIBUTING.md).

## Building voyager
Read [Build Instructions](/docs/developer-guide/build.md) to build voyager.

## Versioning Policy
There are 2 parts to versioning policy:
 - Operator version: Voyager __does not follow semver__, rather the _major_ version of operator points to the
Kubernetes [client-go](https://github.com/kubernetes/client-go#branches-and-tags) version. You can verify this
from the `glide.yaml` file. This means there might be breaking changes between point releases of the operator.
This generally manifests as changed annotation keys or their meaning.
Please always check the release notes for upgrade instructions.
 - TPR version: appscode.com/v1beta1 is considered in beta. This means any changes to the YAML format will be backward
compatible among different versions of the operator.

---

**The voyager operator collects anonymous usage statistics to help us learn how the software is being used and how we can improve it.
To disable stats collection, run the operator with the flag** `--analytics=false`.

---

## Acknowledgement
 - docker-library/haproxy https://github.com/docker-library/haproxy
 - kubernetes/contrib https://github.com/kubernetes/contrib/tree/master/service-loadbalancer
 - kubernetes/ingress https://github.com/kubernetes/ingress
 - xenolf/lego https://github.com/appscode/lego
 - kelseyhightower/kube-cert-manager https://github.com/kelseyhightower/kube-cert-manager
 - PalmStoneGames/kube-cert-manager https://github.com/PalmStoneGames/kube-cert-manager
 - [Kubernetes cloudprovider implementation](https://github.com/kubernetes/kubernetes/tree/master/pkg/cloudprovider)

## Support
If you have any questions, you can reach out to us.
* [Slack](https://slack.appscode.com)
* [Twitter](https://twitter.com/AppsCodeHQ)
