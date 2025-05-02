
---
title: "End-to-End CI/CD Pipeline on Azure: AKS + ACR + Key Vault + Azure DevOps"
date: May 01, 2025
description: "From code commit to containerized deployment — harness the full power of Azure DevOps, AKS, ACR, and Key Vault in one streamlined pipeline."
---

# 🚀 End-to-End CI/CD Pipeline on Azure: AKS + ACR + Key Vault + Azure DevOps

*From code commit to containerized deployment — harness the full power of Azure DevOps, AKS, ACR, and Key Vault in one streamlined pipeline.*

---

## 🧱 Project Overview

**Resources we’ll create and use:**

| Component             | Name              |
|-----------------------|------------------|
| Resource Group        | `devops`         |
| AKS Cluster           | `aks`            |
| Azure Container Registry | `poojareddy`    |
| Azure Key Vault       | `poojavault`     |
| Azure DevOps Repo     | `devops-training`|
| Helm chart + pipeline | In repo          |

---

## 🔧 Step 1: Provision Azure Resources

### ✅ Create a Resource Group:

```bash
az group create --name <resource-group> --location eastus
```

### ✅ Create AKS Cluster:

```bash
az aks create   --resource-group <resource-group>    --name <cluster-name>   --enable-managed-identity   --node-count 1   --generate-ssh-keys
```

### ✅ Create ACR:

```bash
az acr create --resource-group <resource-group>  --name <acr-name> --sku Basic
```

### ✅ Attach ACR to AKS:

```bash
az aks update -n <cluster-name> -g <resource-group>  --attach-acr <acr-name>
```

### ✅ Create Key Vault:

```bash
az keyvault create -n <vault-name> -g <resource-group> 
```
Get the logged in user

```bash
az ad signed-in-user show
```

Role assignment

```bash
az role assignment create   --assignee <client-id>  --role "Key Vault Secrets Officer"   --scope $(az keyvault show --name <vault-name> --query id -o tsv)
```

### ✅ Add a dummy secret:

```bash
az keyvault secret set --vault-name <vault-name> --name dummy-secret --value "mySecretValue"
```

---

## 🔐 Step 2: Setup Azure DevOps

### ✅ Create Service Connections:

- **Azure Resource Manager** → for ACR, AKS, and Key Vault access.
- **Docker Registry** → for Docker build/push (`Docker@2` task).
- *(Optional)* **Kubernetes** → for `HelmDeploy@0` or `Kubectl@0`.

Ensure you enable **“Grant access permission to all pipelines.”**

**Role Assignment**
Do the role assignment to Service connection created for ARM

```bash
az role assignment create   --assignee <client-id>  --role "Key Vault Secrets Officer"   --scope $(az keyvault show --name <vault-name> --query id -o tsv)
```

---

## 📁 Step 3: Repo Structure

```
devops-training/
├── azure-pipelines.yml
├── Dockerfile
├── helm/
│   └── mychart/
│       ├── Chart.yaml
│       ├── templates/
│       │   ├── deployment.yaml
│       │   ├── service.yaml
│       │   └── ingress.yaml
│       └── values.yaml
```

**Repo link**
```bash
https://dev.azure.com/aksdevops-may/_git/aks-devops
```

## Validation

```bash
kubectl get pods,svc
kubectl exec -it <pod-name> -- printenv DUMMY_SECRET
```
