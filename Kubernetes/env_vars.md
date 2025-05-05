
# Managing Environment Variables in Pods

In Kubernetes, environment variables are used to inject configuration into containers. This allows applications to be more flexible and decoupled from the underlying code.

---

## Ways to Set Environment Variables

### 1. Using the `env` Field in the Pod Spec

You can define environment variables directly inside the Pod specification using the `env` field. These are static environment variables.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: env-demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ['sh', '-c', 'echo Hello $MY_VAR; sleep 3600']
    env:
    - name: MY_VAR
      value: "This is a static env var"
```

### 2. Referencing ConfigMap Values

Environment variables can be sourced from a ConfigMap. This decouples configuration data from the code and allows for dynamic values.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: default
data:
  APP_MODE: "production"
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-env-demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ['sh', '-c', 'echo Hello $APP_MODE; sleep 3600']
    env:
    - name: APP_MODE
      valueFrom:
        configMapKeyRef:
          name: app-config
          key: APP_MODE
```

### 3. Referencing Secret Values

You can use Kubernetes Secrets to inject sensitive data (like passwords or API keys) as environment variables into containers.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
  namespace: default
stringData:
  DB_PASSWORD: "supersecret"
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ['sh', '-c', 'echo DB password is $DB_PASSWORD; sleep 3600']
    env:
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: app-secret
          key: DB_PASSWORD
```

### 4. Using the `envFrom` Field

This allows you to import all key-value pairs from a ConfigMap or Secret as environment variables for your container.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: bulk-config
  namespace: default
data:
  VAR1: "value1"
  VAR2: "value2"
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: envfrom-demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ['sh', '-c', 'env; sleep 3600']
    envFrom:
    - configMapRef:
        name: bulk-config
```

### 5. Using the Downward API for Pod Metadata

Kubernetes Downward API allows you to expose pod and container metadata as environment variables.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: downward-api-demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ['sh', '-c', 'echo POD_NAME=$POD_NAME; sleep 3600']
    env:
    - name: POD_NAME
      valueFrom:
        fieldRef:
          fieldPath: metadata.name
```

---

## Best Practices for Managing Environment Variables

- **Use Secrets**: Store sensitive data (e.g., passwords) in Kubernetes Secrets.
- **Use ConfigMaps**: For non-sensitive application configuration, use ConfigMaps.
- **Avoid Overusing `envFrom`**: Use `envFrom` carefully to prevent accidental overwriting of environment variables.
- **Separate Concerns**: Keep environment variables for configuration and secrets separate for better management and security.
- **Use Downward API Sparingly**: Expose runtime metadata only when necessary.

---

## Commands for Testing

Once you apply the YAML files using `kubectl apply -f <filename>.yaml`, you can test the environment variables using the following commands:

```bash
kubectl exec -it <pod-name> -- env
```

To check the value of specific environment variables:

```bash
kubectl exec -it <pod-name> -- printenv MY_VAR
```

---
