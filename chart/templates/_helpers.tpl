{{/*
Base name for all resources. Uses the release name, adding the chart name
unless the release name already contains it (e.g. release "helloworld"
gives "helloworld", release "demo" gives "demo-helloworld").
*/}}
{{- define "helloworld.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/* Labels on every resource, so kubectl -l and Helm tooling can find them. */}}
{{- define "helloworld.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels for one version. Call with a dict: (dict "root" $ "version" "v1").
The plain "app" and "version" labels are what Istio uses for telemetry.
*/}}
{{- define "helloworld.selectorLabels" -}}
app.kubernetes.io/name: {{ .root.Chart.Name }}
app.kubernetes.io/instance: {{ .root.Release.Name }}
app: {{ include "helloworld.fullname" .root }}
version: {{ .version }}
{{- end -}}
