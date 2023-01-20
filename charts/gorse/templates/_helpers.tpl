{{/* vim: set filetype=mustache: */}}

{{/*
Create a default fully qualified mongodb name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gorse.mongodb.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "mongodb" "chartValues" .Values.mongodb "context" $) -}}
{{- end -}}

{{/*
Returns the available value for certain key in an existing secret (if it exists),
otherwise it generates a random value.
*/}}
{{- define "getValueFromSecret" }}
    {{- $len := (default 16 .Length) | int -}}
    {{- $obj := (lookup "v1" "Secret" .Namespace .Name).data -}}
    {{- if $obj }}
        {{- index $obj .Key | b64dec -}}
    {{- else -}}
        {{- randAlphaNum $len -}}
    {{- end -}}
{{- end }}

{{- define "gorse.toTOMLArray" -}}
    {{- $list := list }}
    {{- range .List }}
    {{- $list = append $list (printf "\"%s\"" .) }}
    {{- end }}
    {{- printf "[%s]" (join ", " $list) }}
{{- end }}

{{/*
Return Gorse username
*/}}
{{- define "gorse.auth.username" -}}
{{- if not (empty .Values.gorse.auth.dashboard.username) }}
    {{- .Values.gorse.auth.dashboard.username -}}
{{- else -}}
    {{- "gorse" -}}
{{- end -}}
{{- end -}}

{{/*
Return Gorse password
*/}}
{{- define "gorse.auth.password" -}}
{{- if not (empty .Values.gorse.auth.dashboard.password) }}
    {{- .Values.gorse.auth.dashboard.password -}}
{{- else -}}
    {{- include "getValueFromSecret" (dict "Namespace" .Release.Namespace "Name" (include "common.names.fullname" .) "Length" 10 "Key" "auth-password") -}}
{{- end -}}
{{- end -}}

{{/*
Return Gorse API Secret
*/}}
{{- define "gorse.auth.api" -}}
{{- if not (empty .Values.gorse.auth.api.key) }}
    {{- .Values.gorse.auth.api.key -}}
{{- else -}}
    {{- include "getValueFromSecret" (dict "Namespace" .Release.Namespace "Name" (include "common.names.fullname" .) "Length" 32 "Key" "api-key") -}}
{{- end -}}
{{- end -}}

{{/*
Get MongoDb host
*/}}
{{- define "gorse.mongodb.host" -}}
{{- if eq .Values.mongodb.architecture "replication" }}
    {{- printf "%s-primary" (include "gorse.mongodb.fullname" .) -}}
{{- else }}
    {{- include "gorse.mongodb.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Get MongoDb user
*/}}
{{- define "gorse.mongodb.user" -}}
{{- if .Values.mongodb.enabled }}
    {{- .Values.mongodb.auth.username -}}
{{- end -}}
{{- end -}}

{{/*
Set the proper Database uri. If mongodb is installed as part of this chart, build uri,
else use user-provided uri
*/}}
{{- define "gorse.database.uri" }}
{{- if .Values.mongodb.enabled -}}
    {{- $host := include "gorse.mongodb.host" . -}}
    {{- $port := 27017 -}}
    {{- $user := include "gorse.mongodb.user" . -}}
    {{- $password := .Values.mongodb.auth.password -}}
    {{- $database := .Values.mongodb.auth.database -}}

    {{- printf "mongodb://%s:%s@%s:%d/%s?connect=direct" $user $password $host $port $database }}
{{- else -}}
    {{- .Values.gorse.database.uri }}
{{- end -}}
{{- end -}}


{{/*
Set the proper mongodb uri. If MongoDB is installed as part of this chart, build uri,
else use user-provided uri
*/}}
{{- define "gorse.cache.uri" }}
{{- if .Values.mongodb.enabled -}}
    {{- $host := include "gorse.mongodb.host" . -}}
    {{- $port := 27017 -}}
    {{- $user := include "gorse.mongodb.user" . -}}
    {{- $password := .Values.mongodb.auth.password -}}
    {{- $database := .Values.mongodb.auth.database -}}
    {{- printf "mongodb://%s:%s@%s:%d/%s?connect=direct" $user $password $host $port $database }}
{{- else -}}
    {{- .Values.gorse.cache.uri }}
{{- end -}}
{{- end -}}