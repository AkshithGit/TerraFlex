#Resource-1: Create bastionTier Subnet
resource "azurerm_subnet" "bastion-subnet-block" {
  name = "${azurerm_virtual_network.vnet_block.name}-${var.bastion_subnet_name}"
  address_prefixes = var.bastion_subnet_address
  virtual_network_name = azurerm_virtual_network.vnet_block.name
  resource_group_name = azurerm_resource_group.my_rg_block.name
}
#Resource-2: Create NSG
resource "azurerm_network_security_group" "bastion-subnet-nsg-block" {
  name = "${azurerm_subnet.bastion-subnet-block.name}-nsg"
  location = azurerm_resource_group.my_rg_block.location
  resource_group_name = azurerm_resource_group.my_rg_block.name
}
#Resource-3: Associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "bastion-subnet-nsg-ass-block" {
  depends_on = [ azurerm_network_security_rule.bastion_nsg_rule_inbound  ]# Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354 
  network_security_group_id = azurerm_network_security_group.bastion-subnet-nsg-block.id
  subnet_id = azurerm_subnet.bastion-subnet-block.id
}
#Resource-4: Create NSG Rules# Locals Block for Security Rules
locals {
  bastion_inbound_ports = {
    "100" : "22", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "3389"
  } 
}
# NSG Inbound Rule for bastiontier Subnets
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
  for_each = local.bastion_inbound_ports
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.my_rg_block.name
  network_security_group_name = azurerm_network_security_group.bastion-subnet-nsg-block.name
}



