## Login to Azure and get AKS cluster credentials

**Pre-requisites**
1. Active Azure account
2. Azure CLI
3. Kubectl CLI

First login to azure 
```bash
az login
```
Then check the account details using    
```bash
az account show
```
Once done you can create an AKS cluster 
```bash
az aks create -n aks -g <MyResourceGroup>  --node-count <3> --node-vm-size <Standard_D2s_v3> --generate-ssh-keys
```
You can change the values of resource group, VM node count and VM size as desired. 

Once the process is completed, you can see your cluster on the console. Now lets get the cluster credentials
```bash
az aks get-credentials -n <myAKSCluster> -g <myResourceGroup>
```
You can now access the cluster using Kubectl 
```bash
kubectl get nodes
```

`Note`: you can delete all the resources in a Resource Group using
```bash
az group delete --name <MyResourceGroup> --yes --no-wait
```

## AKS Creation

https://www.youtube.com/watch?v=RUoejLILgyA

## Azure DevOps CICD to AKS

https://www.youtube.com/watch?v=UEyWTeL7PX8

