resource "azurerm_network_interface" "web-nic-block" {
  name = "${local.resource_name_prefix}-web-vm-nic"
  location = azurerm_resource_group.my_rg_block.location
  resource_group_name = azurerm_resource_group.my_rg_block.name
  ip_configuration {
    name = "web-nic-ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.web-subnet-block.id
    public_ip_address_id = azurerm_public_ip.web_pub_ip_block.id
    # primary = true
  }
}

#Resource-2: Create NSG
resource "azurerm_network_security_group" "web-nic-nsg-block" {
  name = "${azurerm_network_interface.web-nic-block.name}-nsg"
  location = azurerm_resource_group.my_rg_block.location
  resource_group_name = azurerm_resource_group.my_rg_block.name
}
#Resource-3: Associate NSG and Nic
resource "azurerm_network_interface_security_group_association" "web-nic-nsg-ass-block" {
  depends_on = [ azurerm_network_security_rule.web_nic_nsg_rule_inbound  ]# Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354 
  network_security_group_id = azurerm_network_security_group.web-nic-nsg-block.id
  network_interface_id = azurerm_network_interface.web-nic-block.id
}
#Resource-4: Create NSG Rules# Locals Block for Security Rules
locals {
  web_nic_inbound_ports = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  }
}
# NSG Inbound Rule for Webtier Subnets
resource "azurerm_network_security_rule" "web_nic_nsg_rule_inbound" {
  for_each = local.web_nic_inbound_ports
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
  network_security_group_name = azurerm_network_security_group.web-nic-nsg-block.name
}