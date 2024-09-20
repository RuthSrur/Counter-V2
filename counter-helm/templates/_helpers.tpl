{{/*
Generate a default fully-qualified app name.
*/}}
{{- define "counter-helm.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
