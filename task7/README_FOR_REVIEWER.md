
### 1. Запуск

```bash
minikube delete
minikube start
```
```bash
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.14/deploy/gatekeeper.yaml
kubectl wait --for=condition=Ready pod -l control-plane=controller-manager -n gatekeeper-system --timeout=300s
```
```bash
kubectl apply -f 01-create-namespace.yaml
```

### 2. Настройка Gatekeeper

```bash
kubectl apply -f gatekeeper/constraint-templates/
kubectl apply -f gatekeeper/constraints/
```

### 3. Тест

```bash
sh ./verify/verify-admission.sh
```

```bash
sh ./verify/validate-security.sh
```