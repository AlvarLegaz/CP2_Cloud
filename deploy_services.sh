#!/bin/bash

cd ansible

echo "Ejecutando playbook"
ansible-playbook -i inventario playbook.yaml -K


