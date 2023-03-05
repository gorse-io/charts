{{/* vim: set filetype=mustache: */}}

{{/*
 Create the name of the service account to use
 */}}
{{- define "gorse.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

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

    {{- printf "mongodb://root:%s@%s:%d/?authSource=admin&connect=direct" $password $host $port }}
{{- else -}}
    {{- .Values.database }}
{{- end -}}
{{- end -}}
