output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vm_username" {
  description = "Nombre de usuario de la máquina virtual"
  value       = azurerm_linux_virtual_machine.myVM1.admin_username
}

output "public_ip_address" {
  description = "IP pública de la máquina virtual"
  value       = azurerm_linux_virtual_machine.myVM1.public_ip_address
}

output "acr_name" {
  description = "El nombre del Azure Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "acr_admin_username" {
  description = "El nombre de usuario del administrador del ACR"
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  description = "La contraseña del administrador del ACR"
  value       = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "kubernetes_cluster_name" {
  description = "El nombre del kluster de kubernetes"
  value = azurerm_kubernetes_cluster.k8s.name
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_key
  sensitive = true
}

output "cluster_password" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].password
  sensitive = true
}

output "cluster_username" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].username
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].host
  sensitive = true
}

