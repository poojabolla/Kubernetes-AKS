# Environment Variables, ConfigMaps, and Secrets

---

## 1. Environment Variables in Kubernetes

### Theory
- Environment variables can be injected into a Pod.
- Useful for providing dynamic configuration without changing application code.

### Example Manifest: Pod with Environment Variables
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: env-pod
spec:
  containers:
  - name: env-container
    image: busybox
    command: ["sh", "-c", "echo Hello $MY_VAR; sleep 3600"]
    env:
    - name: MY_VAR
      value: "CKAD Exam"
```

### Hands-on: Apply and Validate
```bash
kubectl apply -f env-pod.yaml
kubectl exec -it env-pod -- sh
# Inside pod shell
echo $MY_VAR
# Output should be: CKAD Exam
```

---

## 2. ConfigMap in Kubernetes

### Theory
- ConfigMaps store non-sensitive configuration data.
- Can be consumed by Pods as ENV vars or mounted as volumes.

### Create a ConfigMap
```bash
kubectl create configmap app-config --from-literal=APP_MODE=production --from-literal=APP_VERSION=1.0
```

OR via Manifest:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: default
data:
  APP_MODE: "production"
  APP_VERSION: "1.0"
```

### Pod using ConfigMap as Environment Variables
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-pod
spec:
  containers:
  - name: configmap-container
    image: busybox
    command: ["sh", "-c", "env; sleep 3600"]
    envFrom:
    - configMapRef:
        name: app-config
```

### Hands-on: Apply and Validate
```bash
kubectl apply -f app-config.yaml
kubectl apply -f configmap-pod.yaml
kubectl exec -it configmap-pod -- sh
# Inside pod shell
echo $APP_MODE
echo $APP_VERSION
# Outputs should be: production and 1.0 respectively
```

---

## 3. Secret in Kubernetes

### Theory
- Secrets store sensitive data (passwords, tokens, keys).
- Base64 encoded, not fully encrypted by default (needs additional configuration).

### Create a Secret
```bash
kubectl create secret generic db-secret --from-literal=DB_USER=admin --from-literal=DB_PASS=Pa55w0rd
```

OR via Manifest:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
  namespace: default
stringData:
  DB_USER: admin
  DB_PASS: Pa55w0rd
```

> Note: `stringData` auto base64 encodes values. Use `data` if you want to manually encode.

### Pod using Secret as Environment Variables
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
  - name: secret-container
    image: busybox
    command: ["sh", "-c", "env; sleep 3600"]
    envFrom:
    - secretRef:
        name: db-secret
```

### Hands-on: Apply and Validate
```bash
kubectl apply -f db-secret.yaml
kubectl apply -f secret-pod.yaml
kubectl exec -it secret-pod -- sh
# Inside pod shell
printenv DB_USER
printenv DB_PASS
# Outputs should be: admin and Pa55w0rd respectively
```

---

# Quick Summary
| Concept | Object Type | Usage |
| :--- | :--- | :--- |
| Environment Variables | Pod | Inject static values |
| ConfigMap | ConfigMap | Inject non-sensitive configs |
| Secret | Secret | Inject sensitive configs securely |

---

# Practice Tip for CKAD 🚀
- Always know how to use `kubectl run`, `kubectl create configmap`, and `kubectl create secret`.
- Practice writing manifests manually (YAML) during exams.
- Validate via `kubectl exec` to confirm environment variables are injected properly.

---


