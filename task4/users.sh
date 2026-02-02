#!/bin/bash

# developer
openssl genrsa -out dev.key 2048
openssl req -new -key dev.key -out dev.csr -subj "/CN=dev/O=developers"
openssl x509 -req -in dev.csr -CA $(minikube ssh "cat /var/lib/minikube/certs/ca.crt") \
  -CAkey $(minikube ssh "cat /var/lib/minikube/certs/ca.key") \
  -CAcreateserial -out dev.crt -days 365
kubectl config set-credentials dev --client-certificate=dev.crt --client-key=dev.key
kubectl config set-context dev-context --cluster=minikube --namespace=default --user=dev

# user
openssl genrsa -out viewer.key 2048
openssl req -new -key viewer.key -out viewer.csr -subj "/CN=viewer/O=viewers"
openssl x509 -req -in viewer.csr -CA $(minikube ssh "cat /var/lib/minikube/certs/ca.crt") \
  -CAkey $(minikube ssh "cat /var/lib/minikube/certs/ca.key") \
  -CAcreateserial -out viewer.crt -days 365
kubectl config set-credentials viewer --client-certificate=viewer.crt --client-key=viewer.key
kubectl config set-context viewer-context --cluster=minikube --namespace=default --user=viewer