{{- define "postgres-helm.secretName" -}}
{{- if .Values.auth.existingSecret -}}
{{- .Values.auth.existingSecret -}}
{{- else -}}
{{- include "service-base.fullname" . -}}
{{- end -}}
{{- end -}}

{{- define "postgres-helm.passwordKey" -}}
{{- default "password" .Values.auth.passwordKey -}}
{{- end -}}

{{- define "postgres-helm.volumePermissionsImage" -}}
{{- $values := .Values.volumePermissions | default (dict) -}}
{{- $image := $values.image | default (dict) -}}
{{- $registry := "" -}}
{{- if $image.registry -}}
{{- $registry = $image.registry -}}
{{- else if .Values.global.imageRegistry -}}
{{- $registry = .Values.global.imageRegistry -}}
{{- end -}}
{{- $registry = trimSuffix "/" $registry -}}
{{- $repository := required "volumePermissions.image.repository is required when volumePermissions.enabled is true" $image.repository -}}
{{- $tag := required "volumePermissions.image.tag is required when volumePermissions.enabled is true" $image.tag -}}
{{- if $registry -}}
{{- printf "%s/%s:%s" $registry $repository $tag -}}
{{- else -}}
{{- printf "%s:%s" $repository $tag -}}
{{- end -}}
{{- end -}}
