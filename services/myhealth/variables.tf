variable "resource_group_name" {
  default = "myhealth-rg"
  description = "Name of the resource group used for MyHealth"
  type = string 
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "Location used for the resource group for MyHealth"
  type = string
}