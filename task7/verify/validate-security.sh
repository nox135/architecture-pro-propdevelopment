#!/bin/bash

echo "Проверка Pod Security Admission и OPA Gatekeeper"

echo "Создание namespace"
kubectl apply -f 01-create-namespace.yaml

sleep 2

echo "Тестирование небезопасных манифестов"

echo "Privileged pod"
kubectl apply -f insecure-manifests/01-privileged-pod.yaml 2>/dev/null

echo "HostPath pod"
kubectl apply -f insecure-manifests/02-hostpath-pod.yaml 2>/dev/null

echo "Root user pod"
kubectl apply -f insecure-manifests/03-root-user-pod.yaml 2>/dev/null

echo "Тестирование безопасных манифестов"
echo "Secure pod 1"
kubectl apply -f secure-manifests/01-secure.yaml 2>/dev/null

echo "Secure pod 2"
if kubectl apply -f secure-manifests/02-secure.yaml 2>/dev/null

echo "Secure pod 3"
kubectl apply -f secure-manifests/03-secure.yaml 2>/dev/null
