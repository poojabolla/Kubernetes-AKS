#!/bin/bash

ACTION=$1

if [[ "$ACTION" != "start" && "$ACTION" != "stop" ]]; then
  echo "Usage: $0 {start|stop}"
  exit 1
fi

# Common inputs for both start and stop
echo "Enter the Resource Group name:"
read RESOURCE_GROUP

echo "Enter the AKS Cluster name:"
read CLUSTER_NAME

if [ "$ACTION" == "start" ]; then
  echo "Enter the Azure region (e.g., eastus, westeurope):"
  read LOCATION

  NODE_SIZE="Standard_B2s"
  NODE_COUNT=3

  echo "Creating Resource Group: $RESOURCE_GROUP in $LOCATION..."
  az group create \
    --name "$RESOURCE_GROUP" \
    --location "$LOCATION"

  echo "Creating AKS Cluster: $CLUSTER_NAME with $NODE_COUNT nodes of size $NODE_SIZE..."
  az aks create \
    --resource-group "$RESOURCE_GROUP" \
    --name "$CLUSTER_NAME" \
    --node-count "$NODE_COUNT" \
    --node-vm-size "$NODE_SIZE" \
    --generate-ssh-keys

  echo "Setting up kubectl to use the new AKS cluster..."
  az aks get-credentials \
    --resource-group "$RESOURCE_GROUP" \
    --name "$CLUSTER_NAME"

  echo "✅ AKS Cluster '$CLUSTER_NAME' created and kubectl is now configured."
  kubectl get nodes

elif [ "$ACTION" == "stop" ]; then
  echo "⚠️ This will delete the AKS cluster and its resource group!"
  read -p "Are you sure you want to continue? (yes/no): " CONFIRM

  if [[ "$CONFIRM" == "yes" ]]; then
    echo "Deleting resource group '$RESOURCE_GROUP' and all its resources..."
    az group delete \
      --name "$RESOURCE_GROUP" \
      --yes --no-wait
    echo "⛔ Deletion initiated."
  else
    echo "Aborted."
  fi
fi

