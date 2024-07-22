#!/bin/bash

cd ansible

echo "Running playbook"
ansible-playbook -i inventario playbook.yaml -K


