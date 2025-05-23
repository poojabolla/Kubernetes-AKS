# 📚 NGINX Hands-on for Multi-Container Pods & Init Containers

## 🚀 Multi-Container Pods

### 🧠 Theory 

- A **Pod** can contain multiple containers that share the same **network namespace**, **storage volumes**, and **lifecycle**.
- Common patterns:
  - 🔹 **Sidecar**: Helper containers for the main container.
  - 🔹 **Adapter**: Containers transforming output.
  - 🔹 **Ambassador**: Containers acting as proxies.
- **Why?** To split responsibilities and extend functionality without making the main container complex.

**Key Points:**
- 📡 All containers in a pod can communicate via `localhost`.
- 📦 Volumes are shared.

---

### 🛠️ Hands-on Exercise 1: Sidecar Container with NGINX {#hands-on-exercise-1-sidecar-container-with-nginx}

**Objective:** Create a pod with two containers:
- **Main container**: Runs an NGINX server.
- **Sidecar container**: Runs a busybox container that writes logs into a shared volume.

### 📄 Pod Manifest: `multi-container-nginx.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-sidecar-pod
spec:
  containers:
  - name: nginx-container
    image: nginx:1.21
    volumeMounts:
    - name: shared-logs
      mountPath: /usr/share/nginx/html
  - name: log-writer
    image: busybox
    command: ["/bin/sh", "-c", "while true; do echo Hello from Sidecar > /var/log/index.html; sleep 5; done"]
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log
  volumes:
  - name: shared-logs
    emptyDir: {}
```

---

### 🚀 Steps to Deploy

```bash
kubectl apply -f multi-container-nginx.yaml
```

---

### 🔎 Verify

```bash
kubectl get pods
kubectl describe pod nginx-sidecar-pod
kubectl port-forward pod/nginx-sidecar-pod 8080:80
```

🔗 Now visit `http://localhost:8080` — you should see **"Hello from Sidecar"** generated by the sidecar!

---

## 🚀 Init Containers

### 🧠 Theory 

- **Init containers** run **before** app containers start.
- They must **complete successfully** for the Pod to start the main containers.
- Useful for:
  - 📁 Preloading configuration files.
  - 🔧 Setting up preconditions (e.g., database migrations).
  - 🕒 Waiting for external services.

**Key Points:**
- 🖼️ They have different images from app containers.
- ⏳ They run **sequentially**, one after the other.

---

### 🛠️ Hands-on Exercise 2: Init Container to Preload Data for NGINX {#hands-on-exercise-2-init-container-to-preload-data-for-nginx}

**Objective:**
- Use an init container to **copy a welcome HTML page** into a shared volume.
- Main container (NGINX) will **serve** that page.

### 📄 Pod Manifest: `nginx-initcontainer.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-init-pod
spec:
  initContainers:
  - name: init-copy-html
    image: busybox
    command:
    - /bin/sh
    - -c
    - |
      echo "<h1>Welcome to NGINX served by Init Container!</h1>" > /workdir/index.html
    volumeMounts:
    - name: html-volume
      mountPath: /workdir

  containers:
  - name: nginx-container
    image: nginx:1.21
    volumeMounts:
    - name: html-volume
      mountPath: /usr/share/nginx/html

  volumes:
  - name: html-volume
    emptyDir: {}
```

---

### 🚀 Steps to Deploy

```bash
kubectl apply -f nginx-initcontainer.yaml
```

---

### 🔎 Verify

```bash
kubectl get pods
kubectl describe pod nginx-init-pod
kubectl logs nginx-init-pod -c init-copy-html
kubectl port-forward pod/nginx-init-pod 8080:80
```

🔗 Visit `http://localhost:8080` — you should see the HTML content injected by the init container!

---

# 📊 Summary

| Feature | Multi-Container Pods | Init Containers |
| :------ | :------------------- | :-------------- |
| **Purpose** | Enhance pod with multiple functionalities | Prepare pod before app containers start |
| **When Runs** | Simultaneously | Sequentially before app |
| **Typical Use** | Sidecars, log collectors | Data preload, wait for service |

---

# 🎯 Additional Exercises

- 🔢 Modify the sidecar to generate a random number every 5 seconds.
- 🔗 Chain multiple init containers.
- 🏋️ Use `alpine` instead of `busybox` for lightweight base.

---

# 📝 Notes

- 🧹 `emptyDir` is ephemeral — disappears once the pod is deleted.
- 📜 Use `kubectl logs pod-name -c container-name` to fetch logs from a specific container.

---

