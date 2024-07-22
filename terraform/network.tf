# Creation of a network (Virtual network)
resource "azurerm_virtual_network" "myNet" {
  name                  =  "kubernetesnet"
  address_space         =  ["10.0.0.0/16"]
  location              =  azurerm_resource_group.rg.location
  resource_group_name   =  azurerm_resource_group.rg.name

  tags = {
    enviroment = "CP2"
  }
}

# Creation of subnet
resource "azurerm_subnet" "mySubNet" {
  name                  =  "terraformsubnet"
  resource_group_name   =  azurerm_resource_group.rg.name
  virtual_network_name  =  azurerm_virtual_network.myNet.name
  address_prefixes      =  ["10.0.1.0/24"]
}

# Creation of network interface (NIC)
resource "azurerm_network_interface" "myNIC" {
  name                = "vmnic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myipconfiguration1"
    subnet_id                     = azurerm_subnet.mySubNet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    public_ip_address_id          =  azurerm_public_ip.myPublicIp1.id
  }

    tags  =  {
      enviroment = "CP2"
    }
}

# Creation of Public IP
resource "azurerm_public_ip" "myPublicIp1"{
  name  =  "vmip1"
  location              =  azurerm_resource_group.rg.location
  resource_group_name   =  azurerm_resource_group.rg.name
  allocation_method     =  "Dynamic"
  sku                   =  "Basic"

    tags = {
      enviroment = "CP2"
    }
}
