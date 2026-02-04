#!/bin/bash

AUDIT_LOG="./audit.log"
FILTERED_LOG="./filtered_audit.log"

> "$FILTERED_LOG"

# Проверка на события доступа к secrets
jq -c 'select(.objectRef.resource=="secrets" and (.verb=="get" or .verb=="list"))' "$AUDIT_LOG" 2>/dev/null >> "$FILTERED_LOG"

# Проверка на kubectl exec в чужие поды
jq -c 'select(.verb=="create" and .objectRef.subresource=="exec")' "$AUDIT_LOG" 2>/dev/null >> "$FILTERED_LOG"

# Привилегированные поды
jq -c 'select(.objectRef.resource=="pods" and .verb=="create" and (.requestObject.spec.containers // [] | any(.securityContext.privileged==true)))' "$AUDIT_LOG" 2>/dev/null >> "$FILTERED_LOG"

# RBAC эскалация
jq -c 'select((.objectRef.resource=="rolebindings" or .objectRef.resource=="clusterrolebindings") and (.verb=="create" or .verb=="update") and (.requestObject.roleRef.name=="cluster-admin" or .requestObject.roleRef.name=="admin"))' "$AUDIT_LOG" 2>/dev/null >> "$FILTERED_LOG"

# Опасные операции
jq -c 'select((.verb=="delete" or .verb=="deletecollection") and (.objectRef.resource=="pods" or .objectRef.resource=="secrets" or .objectRef.resource=="configmaps"))' "$AUDIT_LOG" 2>/dev/null >> "$FILTERED_LOG"

# Удаление или изменение audit policy
grep -i 'audit-policy' "$AUDIT_LOG" 2>/dev/null >> "$FILTERED_LOG"