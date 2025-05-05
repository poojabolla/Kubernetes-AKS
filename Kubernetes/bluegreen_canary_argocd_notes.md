
# Blue-Green & Canary Deployments in Kubernetes using ArgoCD

## Overview
- What is ArgoCD?
- Introduction to Blue-Green and Canary deployments
- How to implement both strategies in Kubernetes using Argo Rollouts and ArgoCD
- Hands-on examples with YAML manifests
- Best practices and rollback strategies

---

## 🧠 What is ArgoCD?
ArgoCD is a declarative, GitOps continuous delivery tool for Kubernetes.

### Key Features:
- Git as the single source of truth
- Declarative deployment model
- Supports Helm, Kustomize, Jsonnet, and plain YAML
- Visual dashboard for real-time application status
- Automatic synchronization and rollback

---

## 🔁 Blue-Green Deployment Strategy

### Concept
- Maintain two environments: Blue (new), Green (current)
- Switch traffic to Blue once it's validated
- Rollback is easy by pointing traffic back to Green

### Real-Time Use Case
Healthcare records system that requires zero downtime and complete testing before promoting any version to production.

### Argo Rollouts YAML Example
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: patient-app
spec:
  replicas: 3
  strategy:
    blueGreen:
      activeService: patient-app-svc
      previewService: patient-app-preview-svc
      autoPromotionEnabled: false
  selector:
    matchLabels:
      app: patient-app
  template:
    metadata:
      labels:
        app: patient-app
    spec:
      containers:
        - name: patient-app
          image: myregistry/patient-app:v2.0
```

### Hands-on Steps
1. Deploy two services:
   - `patient-app-svc` (Active)
   - `patient-app-preview-svc` (Preview)
2. Sync the application via ArgoCD
3. Validate new version using preview service
4. Promote using CLI or ArgoCD UI:
   ```bash
   kubectl argo rollouts promote patient-app
   ```

### Rollback
```bash
kubectl argo rollouts abort patient-app
```

---

## 🧬 Canary Deployment Strategy

### Concept
- Gradually shift traffic to new version
- Monitor health at each step
- Rollback if issues are detected

### Real-Time Use Case
E-commerce checkout service where the rollout is done in stages and metrics are observed.

### Argo Rollouts YAML Example
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: checkout
spec:
  replicas: 4
  strategy:
    canary:
      steps:
        - setWeight: 10
        - pause: { duration: 2m }
        - setWeight: 50
        - pause: { duration: 5m }
        - setWeight: 100
  selector:
    matchLabels:
      app: checkout
  template:
    metadata:
      labels:
        app: checkout
    spec:
      containers:
        - name: checkout
          image: myregistry/checkout:v2.0
```

### AnalysisTemplate for Metric Checks
```yaml
apiVersion: argoproj.io/v1alpha1
kind: AnalysisTemplate
metadata:
  name: success-rate
spec:
  metrics:
    - name: success-rate
      interval: 30s
      successCondition: result > 0.95
      provider:
        prometheus:
          address: http://prometheus.kube-system:9090
          query: |
            sum(rate(http_requests_total{job="checkout",status=~"2.."}[1m])) /
            sum(rate(http_requests_total{job="checkout"}[1m]))
```

### Hands-on Steps
1. Define `Rollout` with `canary` steps
2. Deploy Prometheus if not available
3. Attach `AnalysisTemplate` to Rollout
4. Sync with ArgoCD and monitor rollout
5. Abort if metric fails:
   ```bash
   kubectl argo rollouts abort checkout
   ```

---

## 🔐 Best Practices
| Practice                        | Why                                                   |
|--------------------------------|--------------------------------------------------------|
| Use readiness/liveness probes  | Ensures proper pod health checks before routing traffic|
| Enable `autoPromotion: false`  | Manual control of live promotion                      |
| Use Git tags for image version | Prevents tag overwrites                               |
| Integrate monitoring tools     | Enables metric-based rollback decisions               |

---

## 📦 GitOps Repo Structure Example
```bash
.
├── apps/
│   ├── patient-app/
│   │   └── rollout-bluegreen.yaml
│   └── checkout/
│       └── rollout-canary.yaml
├── analysis-templates/
│   └── success-rate.yaml
├── argo-apps/
│   ├── patient-app.yaml
│   └── checkout.yaml
```

---

## 🧪 Lab Exercise Summary
- Deploy a Blue-Green rollout using ArgoCD
- Deploy a Canary rollout with Prometheus metric checks
- Test rollout progress via Argo Rollouts dashboard:
  ```bash
  kubectl argo rollouts dashboard
  ```

---

## 📚 References
- ArgoCD: https://argo-cd.readthedocs.io
- Argo Rollouts: https://argoproj.github.io/argo-rollouts
- Prometheus Integration: https://prometheus.io/docs/introduction/overview/
