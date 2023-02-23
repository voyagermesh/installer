# Voyager CRDs

[Voyager CRDs](https://github.com/voyagermesh) - Voyager Custom Resource Definitions

## TL;DR;

```bash
$ helm repo add appscode https://charts.appscode.com/stable/
$ helm repo update
$ helm search repo appscode/voyager-crds --version=v2023.02.22
$ helm upgrade -i voyager-crds appscode/voyager-crds -n voyager --create-namespace --version=v2023.02.22
```

## Introduction

This chart deploys Voyager crds on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+

## Installing the Chart

To install/upgrade the chart with the release name `voyager-crds`:

```bash
$ helm upgrade -i voyager-crds appscode/voyager-crds -n voyager --create-namespace --version=v2023.02.22
```

The command deploys Voyager crds on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall the `voyager-crds`:

```bash
$ helm uninstall voyager-crds -n voyager
```

The command removes all the Kubernetes components associated with the chart and deletes the release.


