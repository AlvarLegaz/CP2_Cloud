# Create a security group and define the traffic we are going to authorize
resource "azurerm_network_security_group" "mySecGroup" {
  name                = "sshtraffic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "NGINX"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8090"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "CP2"
  }
}

# Link the security group to the network interface
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociation1" {
  network_interface_id      =  azurerm_network_interface.myNIC.id
  network_security_group_id =  azurerm_network_security_group.mySecGroup.id
}
