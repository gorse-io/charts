{{/* vim: set filetype=mustache: */}}

{{/*
Create a default fully qualified postgresql name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gorse.postgresql.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "postgresql" "chartValues" .Values.postgresql "context" $) -}}
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
Get PostgreSQL host
*/}}
{{- define "gorse.postgresql.host" -}}
{{- if eq .Values.postgresql.architecture "replication" }}
    {{- printf "%s-primary" (include "gorse.postgresql.fullname" .) -}}
{{- else }}
    {{- include "gorse.postgresql.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Get PostgreSQL user
*/}}
{{- define "gorse.postgresql.user" -}}
{{- if .Values.postgresql.enabled }}
    {{- .Values.postgresql.auth.username -}}
{{- end -}}
{{- end -}}

{{/*
Set the proper Database uri. If postgresql is installed as part of this chart, build uri,
else use user-provided uri
*/}}
{{- define "gorse.database.uri" }}
{{- if .Values.postgresql.enabled -}}
    {{- $host := include "gorse.postgresql.host" . -}}
    {{- $port := 5432 -}}
    {{- $user := include "gorse.postgresql.user" . -}}
    {{- $password := .Values.postgresql.auth.password -}}
    {{- $database := .Values.postgresql.auth.database -}}

    {{- printf "postgres://%s:%s@%s:%d/%s?sslmode=disable" $user $password $host $port $database }}
{{- else -}}
    {{- .Values.gorse.database.uri }}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified Redis name.
*/}}
{{- define "gorse.redis.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "redis" "chartValues" .Values.redis "context" $) -}}
{{- end -}}

{{/*
Get Redis host
*/}}
{{- define "gorse.redis.host" -}}
{{- printf "%s-master" (include "gorse.redis.fullname" .) }}
{{- end -}}

{{/*
Set the proper Redis uri. If Redis is installed as part of this chart, build uri,
else use user-provided uri
*/}}
{{- define "gorse.cache.uri" }}
{{- if .Values.redis.enabled -}}
    {{- $host := include "gorse.redis.host" . -}}

    {{- if .Values.redis.auth.enabled -}}
        {{- printf "redis://:%s@%s" .Values.redis.auth.password  $host }}
    {{- else -}}
        {{- printf "redis://%s" $host }}
    {{- end -}}
{{- else -}}
    {{- .Values.gorse.cache.uri }}
{{- end -}}
{{- end -}}
