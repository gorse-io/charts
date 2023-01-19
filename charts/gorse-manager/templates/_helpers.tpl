{{/* vim: set filetype=mustache: */}}

{{/*
Create a default fully qualified mongodb name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gorse.mongodb.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "mongodb" "chartValues" .Values.mongodb "context" $) -}}
{{- end -}}

{{/*
Set the proper Database uri. If postgresql is installed as part of this chart, build uri,
else use user-provided uri
*/}}
{{- define "database" }}
{{- if .Values.mongodb.enabled -}}
    {{- $host := include "gorse.mongodb.fullname" . -}}
    {{- $port := 5432 -}}
    {{- $password := .Values.mongodb.auth.rootPassword -}}

    {{- printf "mongodb://root:%s@%s:%d/%s?sslmode=disable" $password $host $port }}
{{- else -}}
    {{- .Values.database }}
{{- end -}}
{{- end -}}
