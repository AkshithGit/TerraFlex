locals {
  webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to stacksimplify - WebVM App1 - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to stacksimplify - WebVM App1 - App Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to Stack Simplify - WebVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html
CUSTOM_DATA
}





# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_vm_block" {
  name = "${local.resource_name_prefix}-web-vm"
  #computer_name = "web-linux-vm" # Hostname of the VM (Optional)
  resource_group_name = azurerm_resource_group.my_rg_block.name
  location = azurerm_resource_group.my_rg_block.location
  size = "Standard_B1ms"
  admin_username = "azureuser"
  network_interface_ids = [ azurerm_network_interface.web-nic-block.id  ]
  admin_ssh_key {
    username = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }  
  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }  
  #custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
  custom_data = base64encode(local.webvm_custom_data)
}