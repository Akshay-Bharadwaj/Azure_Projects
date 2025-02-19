#!/bin/bash

RESOURCE_GROUP_NAME=tfstaterg
STORAGE_ACCOUNT_NAME=tfstatesaa$RANDOM
CONTAINER_NAME=tfstate

#create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

#create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

#create blob storage for backend
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME