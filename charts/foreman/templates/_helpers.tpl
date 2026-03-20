{{/*
Expand the name of the chart.
*/}}
{{- define "foreman.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "foreman.fullname" -}}
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
{{- define "foreman.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Chart common labels
*/}}
{{- define "foreman.common.metaLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ include "foreman.chart" . }}
{{- end }}

{{/*
Foreman labels
*/}}
{{- define "foreman.foreman.labels" -}}
{{ include "foreman.common.metaLabels" . }}
{{ include "foreman.foreman.selectorLabels" . }}
{{- end }}

{{- define "foreman.foreman.selectorLabels" -}}
app.kubernetes.io/component: web
app.kubernetes.io/name: foreman
{{- end -}}

{{/*
Frontend selector labels
*/}}

{{- define "foreman.frontend.selectorLabels" -}}
app.kubernetes.io/name: apache
{{- end -}}

{{/*
Frontend labels
*/}}

{{- define "foreman.frontend.labels" -}}
{{ include "foreman.common.metaLabels" . }}
{{ include "foreman.frontend.selectorLabels" . }}
app.kubernetes.io/component: frontend
{{- end }}

{{/*
Dynflow common selector labels
*/}}

{{- define "foreman.dynflow.common.selectorLabels" -}}
app.kubernetes.io/component: dynflow
{{- end -}}

{{/*
Dynflow orchestrator labels
*/}}
{{- define "foreman.dynflow.orchestrator.labels" -}}
{{ include "foreman.common.metaLabels" . }}
{{ include "foreman.dynflow.orchestrator.selectorLabels" . }}
{{- end -}}

{{- define "foreman.dynflow.orchestrator.selectorLabels" -}}
{{ include "foreman.dynflow.common.selectorLabels" . }}
app.kubernetes.io/name: orchestrator
{{- end -}}

{{/*
Dynflow worker labels
*/}}
{{- define "foreman.dynflow.worker.labels" -}}
{{ include "foreman.common.metaLabels" . }}
{{ include "foreman.dynflow.worker.selectorLabels" . }}
{{- end -}}

{{- define "foreman.dynflow.worker.selectorLabels" -}}
{{ include "foreman.dynflow.common.selectorLabels" . }}
app.kubernetes.io/name: worker
{{- end -}}
