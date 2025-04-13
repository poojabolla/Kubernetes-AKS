# 📘 Kubernetes Overview and Use Cases

## 🧠 What is Kubernetes?

**Kubernetes** (aka **K8s**) is an **open-source container orchestration platform** that automates:

- Deployment  
- Scaling  
- Management  
- Networking  
- Availability of containerized applications  

Originally developed by Google, it is now maintained by the **Cloud Native Computing Foundation (CNCF)**.

---

## 🧩 Why Kubernetes?

Before Kubernetes:

- Apps were monolithic
- Scaling was manual
- Downtime during failure was high
- Tight coupling between apps and infrastructure

With Kubernetes:

- Apps run in containers, independent of infrastructure
- Self-healing and auto-scaling
- Safe updates and rollbacks
- Declarative configuration and automation

---

## 🖼️ Architecture Overview

### 🔷 1. Control Plane

Handles the overall cluster management:

- `kube-apiserver` – API entry point  
- `etcd` – Cluster data store  
- `kube-scheduler` – Assigns pods to nodes  
- `kube-controller-manager` – Handles controllers  
- `cloud-controller-manager` – Connects to cloud provider APIs

### 🔶 2. Node Components

Where your workloads actually run:

- `kubelet` – Talks to the control plane  
- `kube-proxy` – Manages network rules  
- Container Runtime (e.g. Docker, containerd)

### 📦 3. Pods

- Smallest unit in Kubernetes
- One or more containers, shared network/storage

---

## 📦 Key Kubernetes Objects

| Object        | Description                                           |
|---------------|-------------------------------------------------------|
| **Pod**       | Group of one or more containers                      |
| **Service**   | Exposes Pods via internal or external IP             |
| **Deployment**| Declarative rollout of Pods                          |
| **ReplicaSet**| Maintains desired number of pod replicas             |
| **ConfigMap** | External configuration for apps                      |
| **Secret**    | Securely stores sensitive data                       |
| **Namespace** | Logical grouping of resources                        |

---

## 🚀 Use Cases

| Use Case                         | Description                                                      |
|----------------------------------|------------------------------------------------------------------|
| **Microservices orchestration** | Manage hundreds of independent services                          |
| **Scalable web apps**           | Scale apps based on load                                         |
| **CI/CD pipelines**             | Automate builds, tests, and deployment                           |
| **Hybrid cloud deployment**     | Unified control across cloud/on-prem                             |
| **Resource optimization**       | Efficient workload packing via scheduler                         |
| **Self-healing systems**        | Auto-restart failed pods, replace unresponsive ones              |

---

## ⚙️ Workflow Example

1. Developer pushes code to Git repo  
2. CI/CD pipeline builds image and pushes to registry  
3. Kubernetes Deployment references image  
4. Pods are created from the image  
5. Service exposes Pods  
6. Autoscaler adjusts number of replicas based on load  

---

## 🛡️ Benefits of Kubernetes

- High availability  
- Infrastructure abstraction  
- Multi-cloud & hybrid-cloud ready  
- Secure and resilient  
- Strong community and tooling support  
