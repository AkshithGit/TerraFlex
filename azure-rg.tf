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

#Create a resource group
resource "azurerm_resource_group" "rg1_block" {
    location = "eastus"
    name = "my-first-rg"
}