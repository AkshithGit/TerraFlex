#Vnet, subnets and subnet NSG's


#vnet name
variable "vnet_name" {
  description = "Virtual Network Name"
  type = string
  default = "vnet-default"
}
#vnet address space
variable "vnet_address-space" {
  description = "Virtual Network Address Space"
  type = list(string)
  default = ["10.0.0.0/16"]
}

#web subnet name
variable "web_subnet_name" {
  description = "Web subnet Name"
  type = string
  default = "default-web-subnet"
}

#web subnet address space
variable "web_subnet_address" {
    description = "Web subnet Address Space"
    type = list(string)
    default = ["10.0.1.0/24"]
}


#App subnet name
variable "app_subnet_name" {
  description = "App subnet name"
  type = string
  default = "default-app-subnet"
}

#App subnet address space
variable "app_subnet_address" {
    description = "App subnet Address Space"
    type = list(string)
    default = ["10.0.2.0/24"]
}

#Database subnet name 
variable "db_subnet_name" {
  description = "DB subnet name"
  type = string
  default = "default-db-subnet"
}
#Database address space 
variable "db_subnet_address" {
    description = "DB subnet Address Space"
    type = list(string)
    default = ["10.0.3.0/24"]
}

#Bastion / Management Subnet Name
variable "bastion_subnet_name" {
  description = "Bastion subnet name"
  type = string
  default = "default-bastion-subnet"
}
#Database address space 
variable "bastion_subnet_address" {
    description = "Bastion subnet Address Space"
    type = list(string)
    default = ["10.0.100.0/24"]
}