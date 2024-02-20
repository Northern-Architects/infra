#!/bin/bash

# Exit if any command fails
set -e

echo "*** deploying resource group"
az group create --name $RESOURCE_GROUP --location "$LOCATION"

echo "*** deploying acr"
az acr create --resource-group $RESOURCE_GROUP --name $ACR_NAME --sku Basic --admin-enabled true

echo "*** checking if image is available"
# If this fails, it's because you didn't upload the image to the container registry which you must do first
az acr repository list --name pinnaclecontainerregistryxwpzybx --output table | grep $CONTAINER_NAME

echo "*** creatining container app environment"
az containerapp env create --name $ENVIRONMENT --resource-group $RESOURCE_GROUP --location "$LOCATION"

echo "*** deploying container app"
az containerapp create --name $CONTAINER_NAME --resource-group $RESOURCE_GROUP --environment $ENVIRONMENT --image $ACR_NAME.azurecr.io/$CONTAINER_NAME --target-port 3000 --ingress 'external' --registry-server $ACR_NAME.azurecr.io --query properties.configuration.ingress.fqdn

