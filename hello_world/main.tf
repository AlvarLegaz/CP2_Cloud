terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "CP2_ResourceGroup"
  location = var.location

  tags = {
    environment = "CP2"
  }
}

resource "azurerm_storage_account" "stAccount" {
  name = "staccountcp2"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group_rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tag = {
    environment = "CP2"
  }
}
