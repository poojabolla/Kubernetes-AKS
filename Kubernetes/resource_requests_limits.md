
# Resource Requests and Limits

In Kubernetes, managing resources for Pods is crucial to ensure efficient scheduling and prevent resource contention. Kubernetes allows you to specify the amount of CPU and memory that a Pod needs and can consume, ensuring that the cluster operates smoothly.

---

## Resource Requests

A resource request is the amount of CPU and memory that Kubernetes will reserve for a container. When a container is scheduled, the scheduler will take resource requests into account to ensure that the container has enough resources available.

### Example of Resource Requests:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-request-demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes; sleep 3600']
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
```

In this example, the `requests` section ensures that the container will get at least `64Mi` of memory and `250m` of CPU (250 milli-CPU units).

---

## Resource Limits

A resource limit defines the maximum amount of CPU and memory a container can use. If a container exceeds the limit, Kubernetes may throttle the container or even terminate it if the usage is sustained.

### Example of Resource Limits:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-limit-demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes; sleep 3600']
    resources:
      limits:
        memory: "128Mi"
        cpu: "500m"
```

Here, the `limits` section ensures that the container will not exceed `128Mi` of memory and `500m` of CPU. If it does, the container will be throttled or killed.

---

## Setting Both Requests and Limits

It’s best practice to set both `requests` and `limits` to ensure the container is allocated adequate resources and is capped at a reasonable level to prevent it from over-consuming resources.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-request-limit-demo
spec:
  containers:
  - name: demo-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes; sleep 3600']
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

---

## Best Practices for Resource Requests and Limits

- **Set Both Requests and Limits**: Always set both `requests` and `limits` to avoid resource starvation and to ensure your Pods have enough resources.
- **Start Small**: Start with lower resource requests and adjust based on actual usage.
- **Monitor and Adjust**: Continuously monitor resource usage and adjust requests and limits as needed.
- **Consider Node Capacity**: Ensure that resource requests and limits do not exceed the available resources on your nodes.

---

## Commands for Testing

```bash
kubectl apply -f <manifest>.yaml
kubectl describe pod <pod-name> # To view resource requests and limits
```

---
