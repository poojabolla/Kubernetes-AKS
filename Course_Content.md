
### **Module 1: Introduction to Kubernetes and Containers**

- What is containerization
- Introduction to Docker
- Kubernetes overview and use cases
- Kubernetes architecture: Control Plane and Node components
- Understanding Kubernetes objects: Pods, ReplicaSets, Deployments, Services
- Kubernetes API server and object management
- Kubernetes CLI: kubectl basics

---

### **Module 2: Pod Design and Application Deployment**

- Creating Pods, Deployments, and ReplicaSets
- Multi-container Pods: sidecar, adapter, ambassador patterns
- Init containers
- Working with ConfigMaps and Secrets
- Probes: Liveness and Readiness
- Managing environment variables in Pods
- Resource requests and limits
- Managing Jobs and CronJobs

---

### **Module 3: Kubernetes Configuration and Imperative Commands**

- Imperative vs Declarative approach
- Writing and applying YAML manifests
- Using kubectl to generate YAML
- Dry-run and output flags for validation
- Labels, selectors, and annotations

---

### **Module 4: Services and Networking**

- Cluster networking overview
- Understanding ClusterIP, NodePort, LoadBalancer services
- Service discovery with kube-dns and CoreDNS
- NetworkPolicies for traffic control
- Configuring ingress rules (basic concepts)

---

### **Module 5: Scheduling in Kubernetes**

- Manual scheduling using nodeName
- Controlling pod placement with nodeSelector
- Affinity and anti-affinity rules
- Taints and tolerations
- Pod priority and preemption

---

### **Module 6: Logging and Monitoring**

- Viewing logs using kubectl logs
- Using kubectl exec for live debugging
- Monitoring resource usage with top commands
- Troubleshooting failed Pods and CrashLoopBackOff
- Event inspection and analysis

---

### **Module 7: Kubernetes Deployment Strategies**  

- Deployment strategies in Kubernetes:
  - Recreate strategy
  - RollingUpdate strategy
- Managing rollouts using:
  - kubectl rollout
  - kubectl rollout status
  - kubectl rollout history
  - kubectl rollout undo
- Updating Deployments with zero downtime
- Scaling and updating Deployments
- Observing update behavior using kubectl get and kubectl describe
- Performing rollbacks in case of failure

---

### **Module 8: Troubleshooting and Debugging**

- Troubleshooting Pods and Deployments
- Troubleshooting networking and Services
- Using events to find root causes
- Debugging node issues
- Tools: describe, logs, exec, port-forward

---

### **Module 9: AKS**

- Azure Basics
- Building and containerising sample app
- Working with AKS
- CICD for AKS using Azure DevOps
- Blue-green & Canary Deployments 

---

