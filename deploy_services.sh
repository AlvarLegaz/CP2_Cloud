#!/bin/bash

cd ansible

echo "Copiando imagenes a repositorio acr"
skopeo login alegazCP2ContainerRegistry.azurecr.io
skopeo copy docker://docker.io/nginx:latest docker://alegazCP2ContainerRegistry.azurecr.io/nginx:latest
skopeo copy docker://mcr.microsoft.com/azuredocs/azure-vote-front:v1 docker://alegazCP2ContainerRegistry.azurecr.io/azure-vote-front:v1
skopeo copy docker://mcr.microsoft.com/azuredocs/azure-vote-back:v1 docker://alegazCP2ContainerRegistry.azurecr.io/azure-vote-back:v1
skopeo copy docker://mcr.microsoft.com/oss/bitnami/redis:6.0.8 docker://alegazCP2ContainerRegistry.azurecr.io/redis:6.0.8

echo "Ejecutando playbook"
ansible-playbook -i inventario playbook.yaml -K


