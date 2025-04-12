# Minikube - Kubernetes Local Cluster (Linux)

## What is Minikube?

Minikube is a lightweight tool that enables you to run a single-node Kubernetes cluster locally on your machine. It is designed for development and testing purposes.

- Helps in learning Kubernetes in a local environment
- Supports most Kubernetes features
- Provides quick and easy setup

---

## ❓ Why Use Minikube?

- ✅ **Quick Setup**: Start a Kubernetes cluster in minutes
- ✅ **Local Development**: No need for cloud-based clusters
- ✅ **Low Resource Usage**: Suitable for laptops and desktops
- ✅ **Experiment Safely**: Break things without affecting production
- ✅ **Full Kubernetes API**: Use `kubectl` as you would on a real cluster
- ✅ **Add-ons Support**: Easily enable features like metrics-server, ingress, dashboard, etc.
- ✅ **Training and Demos**: Good for teaching and showcasing Kubernetes features.
- ✅ **No Cloud Dependency**: Runs on local machine — no internet or cloud setup needed (after installation).

---

## Setup and Installation (Linux)

### Pre-requisites

- Linux OS
- Virtualization support (KVM, VirtualBox, Docker, etc.)
- Install the following tools:


### Install Kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

### Install Minikube

```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
minikube start

kubectl get pods
```
