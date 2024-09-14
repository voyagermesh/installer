{{/*
Expand the name of the chart.
*/}}
{{- define "gateway-converter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gateway-converter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "gateway-converter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gateway-converter.labels" -}}
helm.sh/chart: {{ include "gateway-converter.chart" . }}
{{ include "gateway-converter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gateway-converter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gateway-converter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gateway-converter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gateway-converter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Returns the registry used for operator docker image
*/}}
{{- define "server.registry" -}}
{{- list .Values.registryFQDN .Values.server.registry | compact | join "/" }}
{{- end }}

{{- define "docker.imagePullSecrets" -}}
{{- with .Values.imagePullSecrets -}}
imagePullSecrets:
{{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

{{/*
Prepare certs
*/}}
{{- define "gateway-converter.prepare-certs" -}}
{{- if not ._caCrt }}
{{- $caCrt := "" }}
{{- $serverCrt := "" }}
{{- $serverKey := "" }}
{{- if .Values.apiserver.servingCerts.generate }}
{{- $ca := genCA "ca" 3650 }}
{{- $cn := include "gateway-converter.fullname" . -}}
{{- $altName1 := printf "%s.%s" $cn .Release.Namespace }}
{{- $altName2 := printf "%s.%s.svc" $cn .Release.Namespace }}
{{- $server := genSignedCert $cn nil (list $altName1 $altName2) 3650 $ca }}
{{- $caCrt =  b64enc $ca.Cert }}
{{- $serverCrt = b64enc $server.Cert }}
{{- $serverKey = b64enc $server.Key }}
{{- else }}
{{- $caCrt = required "Required when apiserver.servingCerts.generate is false" .Values.apiserver.servingCerts.caCrt }}
{{- $serverCrt = required "Required when apiserver.servingCerts.generate is false" .Values.apiserver.servingCerts.serverCrt }}
{{- $serverKey = required "Required when apiserver.servingCerts.generate is false" .Values.apiserver.servingCerts.serverKey }}
{{- end }}

{{ $_ := set $ "_caCrt" $caCrt }}
{{ $_ := set $ "_serverCrt" $serverCrt }}
{{ $_ := set $ "_serverKey" $serverKey }}

{{- end }}
{{- end }}
