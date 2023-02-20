{{/* vim: set filetype=mustache: */}}

{{/*
Create a default fully qualified mongodb name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gorse.mongodb.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "mongodb" "chartValues" .Values.mongodb "context" $) -}}
{{- end -}}

{{- define "gorse.master.fullname" -}}
{{ printf "%s-master" (include "common.names.fullname" .) }}
{{- end -}}

{{- define "gorse.server.fullname" -}}
{{ printf "%s-server" (include "common.names.fullname" .) }}
{{- end -}}

{{- define "gorse.worker.fullname" -}}
{{ printf "%s-worker" (include "common.names.fullname" .) }}
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
{{- define "gorse.dashboardUsername" -}}
{{- if not (empty .Values.gorse.dashboard.username) }}
    {{- .Values.gorse.dashboard.username -}}
{{- else -}}
    {{- "gorse" -}}
{{- end -}}
{{- end -}}

{{/*
Return Gorse password
*/}}
{{- define "gorse.dashboardPassword" -}}
{{- if not (empty .Values.gorse.dashboard.password) }}
    {{- .Values.gorse.dashboard.password -}}
{{- else -}}
    {{- include "getValueFromSecret" (dict "Namespace" .Release.Namespace "Name" (include "common.names.fullname" .) "Length" 10 "Key" "dashboard-password") -}}
{{- end -}}
{{- end -}}

{{/*
Return Gorse API Secret
*/}}
{{- define "gorse.apiKey" -}}
{{- if not (empty .Values.gorse.api.key) }}
    {{- .Values.gorse.api.key -}}
{{- else -}}
    {{- include "getValueFromSecret" (dict "Namespace" .Release.Namespace "Name" (include "common.names.fullname" .) "Length" 32 "Key" "api-key") -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB Hostname
*/}}
{{- define "gorse.databaseHost" -}}
{{- if .Values.mongodb.enabled }}
    {{- if eq .Values.mongodb.architecture "replication" }}
        {{- printf "%s-primary" (include "gorse.mongodb.fullname" .) | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- printf "%s" (include "gorse.mongodb.fullname" .) -}}
    {{- end -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB Port
*/}}
{{- define "gorse.databasePort" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "27017" -}}
{{- else -}}
    {{- printf "%d" (.Values.externalDatabase.port | int ) -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB Database Name
*/}}
{{- define "gorse.databaseName" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "%s" .Values.mongodb.auth.database -}}
{{- else -}}
    {{- printf "%s" .Values.externalDatabase.database -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB User
*/}}
{{- define "gorse.databaseUser" -}}
{{- if .Values.mongodb.enabled }}
    {{- .Values.mongodb.auth.username -}}
{{- else -}}
    {{- .Values.externalDatabase.username -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB Secret Name
*/}}
{{- define "gorse.databaseSecretName" -}}
{{- if .Values.mongodb.enabled }}
    {{- if .Values.mongodb.auth.existingSecret -}}
        {{- printf "%s" .Values.mongodb.auth.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "gorse.mongodb.fullname" .) -}}
    {{- end -}}
{{- else if .Values.externalDatabase.existingSecret -}}
    {{- include "common.tplvalues.render" (dict "value" .Values.externalDatabase.existingSecret "context" $) -}}
{{- else -}}
    {{- printf "%s-externaldb" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the MongoDB secret key
*/}}
{{- define "gorse.databaseSecretPasswordKey" -}}
{{- if .Values.mongodb.enabled }}
    {{- printf "mongodb-passwords" -}}
{{- else -}}
    {{- .Values.externalDatabase.existingSecretPasswordKey -}}
{{- end -}}
{{- end -}}
