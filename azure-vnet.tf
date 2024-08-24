#Create a Virtual Network

resource "azurerm_virtual_network" "vnet_block" {
  name                = "first-vnet"
  location            = azurerm_resource_group.rg1_block.location
  resource_group_name = azurerm_resource_group.rg1_block.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_network_security_group" "nsg_block" {
  name                = "first_nsg"
  location            = azurerm_resource_group.rg1_block.location
  resource_group_name = azurerm_resource_group.rg1_block.name
}

#Create a Subnet
resource "azurerm_subnet" "subnet_block" {
  name = "first_subnet"
  address_prefixes = [ "10.0.1.0/24" ]
  resource_group_name = azurerm_resource_group.rg1_block.name
  virtual_network_name = azurerm_virtual_network.vnet_block.name
}

#Create Public Ip Address
resource "azurerm_public_ip" "ip_block" {
  name = "mypublic-ip-1"
  resource_group_name = azurerm_resource_group.rg1_block.name
  location = azurerm_resource_group.rg1_block.location
  allocation_method = "Static"
tags = {
  "environment" = "Dev"
}

}
#Create Network Interface
resource "azurerm_network_interface" "first_ni" {
  name = "my-first-nic"
  location = azurerm_resource_group.rg1_block.location
  resource_group_name = azurerm_resource_group.rg1_block.name
  ip_configuration {
    private_ip_address_allocation = "Dynamic"
    name = "first-nic-ipconfig"
    public_ip_address_id = azurerm_public_ip.ip_block.id
    subnet_id = azurerm_subnet.subnet_block.id
  }
}
