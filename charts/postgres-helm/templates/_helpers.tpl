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
