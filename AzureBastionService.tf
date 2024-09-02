#Create AzureBastionSubnet

resource "azurerm_subnet" "bastionservicesubnet_block" {
  name = var.bastion_service_subnet_name
  address_prefixes = var.bastion_service_address_prefixes
  resource_group_name = azurerm_resource_group.my_rg_block.name
  virtual_network_name = azurerm_virtual_network.vnet_block.name
}

#Create AzureBastionPublicIp
resource "azurerm_public_ip" "bastion_service_public_Ip_block" {
  name = "${local.resource_name_prefix}-bastion-service-public-ip"
  location = azurerm_resource_group.my_rg_block.location
  resource_group_name = azurerm_resource_group.my_rg_block.name
  sku = "Standard"
  allocation_method = "Static"
}
#create AzureBastion Service host

resource "azurerm_bastion_host" "bastion_service_host_block" {
  name = "${local.resource_name_prefix}-bastion-service"
  location = azurerm_resource_group.my_rg_block.location
  resource_group_name = azurerm_resource_group.my_rg_block.name
  ip_configuration {
    name = "configuration"
    public_ip_address_id = azurerm_public_ip.bastion_service_public_Ip_block.id
    subnet_id = azurerm_subnet.bastionservicesubnet_block.id
  }
}