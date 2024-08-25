# Generic Input variables
# Business Division
variable "business_division" {
  description = "Business Division in the large organisation this Infrastructure belongs to"
  type = string
  default = "sap"
}
# Environment variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}
# Azure Resource group Name
variable "resource_group_name" {
    description = "Resource Group Name"
    type = string
    default = "rg-default"
}
# Azure Resources Location
variable "resource_group_location" {
    description = "Region in which Azure resources to be created"
    type = string
    default = "eastus"
}
variable "subscription" {
  description = "This the subscription id for the azure"
  type = string
}