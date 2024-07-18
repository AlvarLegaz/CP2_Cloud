terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.93.0"
    }
    
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }

  required_version = ">= 1.1.0"
}

#Define el proveedor
provider "azurerm" {
  features {}
}

#Define el resource group
resource "azurerm_resource_group" "rg" {
  name     = "CP2_ResourceGroup"
  location = var.location

  tags = {
    environment = "CP2"
  }
}

resource "azurerm_storage_account" "stAccount" {
  name                     = "alegazstaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "CP2"
  }
}

#Define el cluster de kubernetes
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "alegazk8s"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "alegazk8snamespace"

  sku_tier = "Standard" # Nivel de precios como Standard, version free no disponible

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.node_count
  }
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}

#Define el resource group
resource "azurerm_container_registry" "acr" {
  name                = "alegazCP2ContainerRegistry"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    environment = "CP2"
  }
}

# Asigna el rol AcrPull al Managed Identity del AKS
resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}
