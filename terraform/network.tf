# Creación de una red (Virtual network)
resource "azurerm_virtual_network" "myNet" {
  name  =  "kubernetesnet"
  address_space  =  ["10.0.0.0/16"]
  location  =  azurerm_resource_group.rg.location
  resource_group_name  =  azurerm_resource_group.rg.name

  tags = {
    enviroment = "CP2"
  }
}

# Creación de subnet
resource "azurerm_subnet" "mySubNet" {
  name  =  "terraformsubnet"
  resource_group_name  =  azurerm_resource_group.rg.name
  virtual_network_name  =  azurerm_virtual_network.myNet.name
  address_prefixes  =  ["10.0.0.0/24"]
}
