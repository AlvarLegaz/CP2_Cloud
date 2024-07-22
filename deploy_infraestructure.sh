#!/bin/bash

cd terraform

# Init Terraform
echo "Ini Terraform..."
terraform init

# Ejecuta el plan de Terraform
echo "Initializing Terraform plan..."
terraform plan

# Apply Terraform plan
echo "Applying Terraform plan..."
terraform apply -auto-approve

# Show and save deploy output data.

echo "Deploy output data"

RG_NAME=$(terraform output -raw resource_group_name)
VM_USERNAME=$(terraform output -raw vm_username)
VM_PUBLIC_IP=$(terraform output -raw public_ip_address)
ACR_NAME=$(terraform output -raw acr_name)
ACR_ADMIN_USERNAME=$(terraform output -raw acr_admin_username)
ACR_ADMIN_PASSWORD=$(terraform output -raw acr_admin_password)
AKS_CULSTER_NAME=$(terraform output -raw kubernetes_cluster_name)

cd ..
# Display output data
echo "RG_NAME: $RG_NAME"
echo "VM_USERNAME: $VM_USERNAME"
echo "VM_PUBLIC_IP: $VM_PUBLIC_IP"
echo "ACR_NAME: $ACR_NAME"
echo "ACR_ADMIN_USERNAME: $ACR_ADMIN_USERNAME"
echo "ACR_ADMIN_PASSWORD: $ACR_ADMIN_PASSWORD"
echo "AKS_CULSTER_NAME: $AKS_CULSTER_NAME"

# Save output data
echo "RG_NAME: $RG_NAME" > deploy_terraform_output.txt
echo "VM_USERNAME: $VM_USERNAME" >> deploy_terraform_output.txt
echo "VM_PUBLIC_IP: $VM_PUBLIC_IP" >> deploy_terraform_output.txt
echo "ACR_NAME: $ACR_NAME" >> deploy_terraform_output.txt
echo "ACR_ADMIN_USERNAME: $ACR_ADMIN_USERNAME" >> deploy_terraform_output.txt
echo "ACR_ADMIN_PASSWORD: $ACR_ADMIN_PASSWORD" >> deploy_terraform_output.txt
echo "AKS_CULSTER_NAME: $AKS_CULSTER_NAME" >> deploy_terraform_output.txt

# Asks if you want to run the 'terraform destroy' command
cd terraform
echo "Do you want to run the 'terraform destroy' command? (y/n)"
read DESTROY

if [ "$DESTROY" = "y" ]; then
  echo "Running 'terraform destroy'..."
  terraform destroy -auto-approve
else
  echo "'Terraform destroy' will not be run."
fi
