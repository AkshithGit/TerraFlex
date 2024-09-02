#Create a virtual network
resource "azurerm_virtual_network" "vnet_block" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}"
  address_space       = var.vnet_address-space
  location            = azurerm_resource_group.my_rg_block.location
  resource_group_name = azurerm_resource_group.my_rg_block.name
  tags                = local.common_tags
}
