# Kubernetes Gateway API

[Kubernetes Gateway API](https://gateway-api.sigs.k8s.io) - Kubernetes Gateway API

## TL;DR;

```bash
$ helm repo add appscode https://charts.appscode.com/stable/
$ helm repo update
$ helm search repo appscode/gateway-api --version=v2024.9.30
$ helm upgrade -i gateway-api appscode/gateway-api -n envoy-gateway-system --create-namespace --version=v2024.9.30
```

## Introduction

This chart deploys Kubernetes Gateway API on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.20+

## Installing the Chart

To install/upgrade the chart with the release name `gateway-api`:

```bash
$ helm upgrade -i gateway-api appscode/gateway-api -n envoy-gateway-system --create-namespace --version=v2024.9.30
```

The command deploys Kubernetes Gateway API on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall the `gateway-api`:

```bash
$ helm uninstall gateway-api -n envoy-gateway-system
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


