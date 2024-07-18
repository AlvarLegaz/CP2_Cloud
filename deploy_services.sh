#!/bin/bash

cd ansible

echo "Copiando imagenes a repositorio acr"
skopeo login alegazCP2ContainerRegistry.azurecr.io
skopeo copy docker://docker.io/nginx:latest docker://alegazCP2ContainerRegistry.azurecr.io/nginx:latest

echo "Ejecutando playbook"
ansible-playbook -i inventario playbook_podman.yaml -K


