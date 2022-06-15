{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "covid19-dashboard.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "covid19-dashboard.ui.name" -}}
{{- printf "%s-%s" (include "covid19-dashboard.name" .) .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "covid19-dashboard.api.name" -}}
{{- printf "%s-%s" (include "covid19-dashboard.name" .) .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "covid19-dashboard.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "covid19-dashboard.ui.fullname" -}}
{{- printf "%s-%s" (include "covid19-dashboard.fullname" .) .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "covid19-dashboard.api.fullname" -}}
{{- printf "%s-%s" (include "covid19-dashboard.fullname" .) .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "covid19-dashboard.chart" -}}
{{- printf "covid19-dashboard" -}}
{{- end -}}

{{- define "covid19-dashboard.api.chart" -}}
{{- printf "covid19-dashboard-api" -}}
{{- end -}}

{{- define "covid19-dashboard.ui.chart" -}}
{{- printf "covid19-dashboard-ui" -}}
{{- end -}}


{{/*Common labels*/}}

{{- define "covid19-dashboard.labels" -}}
helm.sh/chart: {{ include "covid19-dashboard.chart" . }}
{{ include "covid19-dashboard.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "covid19-dashboard.api.labels" -}}
helm.sh/chart: {{ include "covid19-dashboard.api.chart" . }}
{{ include "covid19-dashboard.api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "covid19-dashboard.ui.labels" -}}
helm.sh/chart: {{ include "covid19-dashboard.ui.chart" . }}
{{ include "covid19-dashboard.ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*Selector labels*/}}
{{- define "covid19-dashboard.selectorLabels" -}}
app.kubernetes.io/name: {{ include "covid19-dashboard.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{- define "covid19-dashboard.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "covid19-dashboard.api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "covid19-dashboard.ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "covid19-dashboard.ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*Create the name of the service account to use*/}}

{{- define "covid19-dashboard.api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "covid19-dashboard.api.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "covid19-dashboard.ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "covid19-dashboard.ui.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
