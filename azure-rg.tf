#Terraform Settings block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
  }
}
#Provider Block
provider "azurerm" {
  features {}
}
/*
provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = false # This will ensure when the Virtual Machine is destroyed, Disk is not deleted, default is true and we can alter it at provider level
    }
  }
  alias = "provider2-westus"
  #client_id = "XXXX"
  #client_secret = "YYY"
  #environment = "german"
  #subscription_id = "JJJJ"
}
*/

#Create a resource group
resource "azurerm_resource_group" "rg1_block" {
    location = "eastus"
    name = "my-first-rg"
}

/*
resource "azurerm_resource_group" "rg2_block" {
  location = "westus"
  name = "my-second-rg"
  provider = azurerm.provider2-westus
}
*/