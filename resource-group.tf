#Resource Group create
resource "azurerm_resource_group" "my_rg_block" {
  #name = "${local.resource_name_prefix}-${var.resource_group_name}"
  name     = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.random-string-gen.id}"
  location = var.resource_group_location
  tags     = local.common_tags
}
