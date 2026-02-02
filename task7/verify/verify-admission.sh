#!/bin/bash

echo  "constraint template privileged: true"
kubectl apply -f gatekeeper/constraint-templates/privileged.yaml
echo  "constraint privileged: true"
kubectl apply -f gatekeeper/constraints/privileged.yaml

echo  "constraint template hostPath"
kubectl apply -f gatekeeper/constraint-templates/hostpath.yaml
echo  "constraint hostPath"
kubectl apply -f gatekeeper/constraints/hostpath.yaml

echo  "constraint template runAsNonRoot: true"
kubectl apply -f gatekeeper/constraint-templates/runasnonroot.yaml
echo  "constraint runAsNonRoot: true"
kubectl apply -f gatekeeper/constraints/runasnonroot.yaml