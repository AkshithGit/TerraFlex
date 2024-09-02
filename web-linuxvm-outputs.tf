#Create output values for public_ip
# output "public_ip_out" {
#   value = azurerm_public_ip.web_pub_ip_block.ip_address
#   description = "Displays the public ip address assigned to the web linux server"
# }
output "web_linuxvm_network_interface_id" {
  description = "This is the id of the nic assigned to the web seerver"
  value = azurerm_network_interface.web-nic-block.id
}
output "web_linuxvm_network_interface_private_ip_address" {
  description = "This is the web vm private ip address"
  value = azurerm_network_interface.web-nic-block.private_ip_address
}
output "web_linuxvm_private_ip_address" {
  description = "This is the private ip address assigned to linux vm"
  value = azurerm_linux_virtual_machine.web_vm_block.private_ip_address
}
