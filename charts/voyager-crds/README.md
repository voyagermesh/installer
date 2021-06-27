# Voyager CRDs

[Voyager CRDs](https://github.com/voyagermesh) - Voyager Custom Resource Definitions

## TL;DR;

```console
$ helm repo add appscode https://charts.appscode.com/stable/
$ helm repo update
$ helm install voyager-crds appscode/voyager-crds -n voyager
```

## Introduction

This chart deploys Voyager crds on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.16+

## Installing the Chart

To install the chart with the release name `voyager-crds`:

```console
$ helm install voyager-crds appscode/voyager-crds -n voyager
```

The command deploys Voyager crds on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `voyager-crds`:

```console
$ helm delete voyager-crds -n voyager
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


