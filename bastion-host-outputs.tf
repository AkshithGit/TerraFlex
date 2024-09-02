output "bastion_host_linuxvm_public_ip" {
  description = "This is the public ip of the bastion host"
  value = azurerm_public_ip.bastion_host_publicip.ip_address
}
