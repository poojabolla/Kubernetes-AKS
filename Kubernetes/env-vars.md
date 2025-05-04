Managing Environment Variables in Pods

In Kubernetes, environment variables can be used to pass configuration data into containers. This helps decouple configuration from code and allows for more dynamic and flexible application deployments.

Ways to Set Environment Variables

Kubernetes supports the following methods for injecting environment variables into Pods:

1. Using env field in the Pod spec

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

2. Referencing ConfigMap values

apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: default
data:
  APP_MODE: "production"

---

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

3. Referencing Secret values

apiVersion: v1
kind: Secret
metadata:
  name: app-secret
  namespace: default
stringData:
  DB_PASSWORD: "supersecret"

---

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

4. Using the envFrom field

This allows importing all keys from a ConfigMap or Secret as environment variables.

apiVersion: v1
kind: ConfigMap
metadata:
  name: bulk-config
  namespace: default
data:
  VAR1: "value1"
  VAR2: "value2"

---

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

5. Environment Variables from Downward API

You can expose Pod and container field values as environment variables using the Downward API.

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

Best Practices

Use Secrets to store sensitive data like passwords and API keys.

Prefer ConfigMaps for non-sensitive configuration values.

Use envFrom with caution to avoid unintentional key conflicts.

Use Downward API for exposing runtime metadata to the container.

Commands for Testing

kubectl apply -f <manifest>.yaml
kubectl exec -it <pod-name> -- env

Next: Resource Requests and Limits

