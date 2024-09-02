output "web_lb_pip" {
  value = azurerm_public_ip.web_lb_pip.ip_address
}

output "web_lb_frontend_ip_configuration" {
  value = [azurerm_lb.web_lb.frontend_ip_configuration]
}