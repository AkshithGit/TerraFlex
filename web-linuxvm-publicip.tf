# resource "azurerm_public_ip" "web_pub_ip_block" {
#   name = "${local.resource_name_prefix}-web-linux-vm-publicip"
#   resource_group_name = azurerm_resource_group.my_rg_block.name
#   location = azurerm_resource_group.my_rg_block.location
#   allocation_method = "Static"
#   sku = "Standard"
#   domain_name_label = "app1-vm-${random_string.random-string-gen.id}"
# }