{{/*
Generate labels for the application.
*/}}
{{- define "counter-helm.labels" -}}
app: {{ include "counter-helm.fullname" . }}
chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end -}}
