#Create a Public Ip for Load balancer
resource "azurerm_public_ip" "web_lb_pip" {
  name                = "${local.resource_name_prefix}-web_lb_pip"
  resource_group_name = azurerm_resource_group.my_rg_block.name
  location            = azurerm_resource_group.my_rg_block.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = local.common_tags
}

#Create Azure Standard LoadBalancer
resource "azurerm_lb" "web_lb" {
  name                = "${local.resource_name_prefix}-web_lb"
  resource_group_name = azurerm_resource_group.my_rg_block.name
  location            = azurerm_resource_group.my_rg_block.location

  sku = "Standard"
  frontend_ip_configuration {
    name                 = "web-lb-pip-config"
    public_ip_address_id = azurerm_public_ip.web_lb_pip.id
  }
}

#Create Loadbalancer Backend pool
resource "azurerm_lb_backend_address_pool" "web-lb-address-pool" {
  name = "web-backend"

  loadbalancer_id = azurerm_lb.web_lb.id

}

#Create Loadbalancer Probe
resource "azurerm_lb_probe" "web-lb-probe" {
  name            = "tcp-probe"
  loadbalancer_id = azurerm_lb.web_lb.id
  protocol        = "Tcp"
  port            = 80
}

#Create Loadbalancer Rule
resource "azurerm_lb_rule" "web-lb-rule-app1" {
  name                           = "web-app1-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web-lb-address-pool.id]
  probe_id                       = azurerm_lb_probe.web-lb-probe.id
  loadbalancer_id                = azurerm_lb.web_lb.id
}

# Associate Network Interface and Standard Loadbalancer

resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_associate" {
  network_interface_id    = azurerm_network_interface.web-nic-block.id
  ip_configuration_name   = azurerm_network_interface.web-nic-block.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web-lb-address-pool.id
}

#Inbound Nat rule

resource "azurerm_lb_nat_rule" "web-inbound-lb-nat-rule-22" {
  name                           = "ssh-1022-vm-22"
  protocol                       = "Tcp"
  frontend_port                  = 1022
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  loadbalancer_id                = azurerm_lb.web_lb.id
  resource_group_name            = azurerm_resource_group.my_rg_block.name
}

#Create lb nat rule and vm association

resource "azurerm_network_interface_nat_rule_association" "web_nic_nar_rule_association" {
  nat_rule_id           = azurerm_lb_nat_rule.web-inbound-lb-nat-rule-22.id
  network_interface_id  = azurerm_network_interface.web-nic-block.id
  ip_configuration_name = azurerm_network_interface.web-nic-block.ip_configuration[0].name
}