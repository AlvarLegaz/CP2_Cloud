#!/bin/bash

cd terraform

# Inicializa Terraform
echo "Inicializando Terraform..."
terraform init

# Ejecuta el plan de Terraform
echo "Ejecutando el plan de Terraform..."
terraform plan

# Aplica el plan de Terraform
echo "Aplicando el plan de Terraform..."
terraform apply -auto-approve

# Muestra salidas del despliegue y las almacena en fichero de salidas

echo "Datos del despliegue"

RG_NAME=$(terraform output -raw resource_group_name)
VM_USERNAME=$(terraform output -raw vm_username)
VM_PUBLIC_IP=$(terraform output -raw public_ip_address)
ACR_NAME=$(terraform output -raw acr_name)
ACR_ADMIN_USERNAME=$(terraform output -raw acr_admin_username)
ACR_ADMIN_PASSWORD=$(terraform output -raw acr_admin_password)

cd ..
# Muestra los datos de despliegue por pantalla
echo "RG_NAME: $RG_NAME"
echo "VM_USERNAME: $VM_USERNAME"
echo "VM_PUBLIC_IP: $VM_PUBLIC_IP"
echo "ACR_NAME: $ACR_NAME"
echo "ACR_ADMIN_USERNAME: $ACR_ADMIN_USERNAME"
echo "ACR_ADMIN_PASSWORD: $ACR_ADMIN_PASSWORD"

# Escribe los datos de despliegue en fichero
echo "RG_NAME: $RG_NAME" > deploy_terraform_output.txt
echo "VM_USERNAME: $VM_USERNAME" >> deploy_terraform_output.txt
echo "VM_PUBLIC_IP: $VM_PUBLIC_IP" >> deploy_terraform_output.txt
echo "ACR_NAME: $ACR_NAME" >> deploy_terraform_output.txt
echo "ACR_ADMIN_USERNAME: $ACR_ADMIN_USERNAME" >> deploy_terraform_output.txt
echo "ACR_ADMIN_PASSWORD: $ACR_ADMIN_PASSWORD" >> deploy_terraform_output.txt

# Solicita el nombre de usuario para la conexión SSH
#echo "Por favor, introduce el nombre de usuario para la conexión SSH:"
#read SSH_USER

# Intenta establecer una conexión SSH
# echo "Intentando establecer una conexión SSH a la máquina virtual..."
# ssh ${SSH_USER}@${VM_IP} -i /home/alegaz/.ssh/id_rsa

# Pregunta si quieres ejecutar el comando 'terraform destroy'
cd terraform
echo "¿Quieres ejecutar el comando 'terraform destroy'? (s/n)"
read DESTROY

if [ "$DESTROY" = "s" ]; then
  echo "Ejecutando 'terraform destroy'..."
  terraform destroy -auto-approve
else
  echo "No se ejecutará 'terraform destroy'."
fi
