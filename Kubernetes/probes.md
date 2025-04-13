# 📘 Kubernetes Probes (with NGINX Hands-on)

---

## ✅ 1. What Are Kubernetes Probes?

Kubernetes uses **probes** to monitor the health and availability of containers in pods.

There are 3 types of probes:

| Probe Type    | Purpose                                           | Behavior when Fails                                |
|---------------|---------------------------------------------------|-----------------------------------------------------|
| **Readiness** | Is the container ready to receive traffic?        | Pod is **removed** from Service endpoints           |
| **Liveness**  | Is the container healthy and running?             | Pod/container is **restarted**                     |
| **Startup**   | Is the app fully started before probing begins?   | Temporarily disables liveness/readiness probes      |

---

## 🔍 2. Probe Type Deep Dive

### 🟢 Readiness Probe
- Used to determine when a pod can **start receiving traffic**
- Checked **continuously**, not just at startup
- If it fails:
  - Pod stays `Running`
  - It is **removed from service endpoints**
  - No restart happens

### 🔴 Liveness Probe
- Used to determine if a pod is **stuck or unhealthy**
- If it fails:
  - Kubernetes **restarts the container**

### 🟡 Startup Probe
- Optional
- Used for slow-starting apps
- Disables other probes until the app is ready

---

## 🧪 3. Hands-On: NGINX with Readiness & Liveness Probes

### Step 1: Create a Deployment with Probes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-probe-demo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 80
          readinessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 10
            periodSeconds: 10
```
---

## 🚀 Step 2: Apply the Manifest

Deploy the NGINX pod with probes using:

```bash
kubectl apply -f nginx-probes.yaml
```

---

## 🔍 Step 3: Check Pod and Probe Status

Verify that the pod is running and the probes are configured correctly:

```bash
kubectl get pods
kubectl describe pod &lt;pod-name&gt;
```

> Replace `<pod-name>` with the actual pod name from the `kubectl get pods` output.

---

## 💥 Step 4: Simulate a Readiness Probe Failure

We’ll make the readiness probe fail by deleting the default index file served by NGINX:

```bash
kubectl exec -it &lt;pod-name&gt; -- rm /usr/share/nginx/html/index.html
```

Then check if the pod is removed from the service endpoints:

```bash
kubectl get endpoints
```

### ✅ What You Should See

- The pod stays in **Running** state.
- It is **removed from Service endpoints** (readiness probe failed).
- The pod is **not restarted** unless the **liveness** probe also fails.

---

## 🧠 Key Takeaways

- **Readiness Probe**
  - Used to decide when a pod is **ready to receive traffic**
  - If it fails, the pod is removed from service load balancer
- **Liveness Probe**
  - Used to check if a container is **alive**
  - If it fails, the container is restarted
- **Startup Probe**
  - Optional: disables the above probes during app startup
- **Readiness runs continuously**, not just at startup

---

## 🧼 Cleanup

To remove the deployment:

```bash
kubectl delete deployment nginx-probe-demo
```

---

## ✅ Bonus Tip

To verify if your pod is part of a Service's endpoints:

```bash
kubectl get endpoints
```

- If readiness fails, your pod disappears from the list.
- It remains in `Running` state but won’t receive traffic from the service.

---
