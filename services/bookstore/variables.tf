variable "resource_group_name" {
  default = "velidabookstore-rg"
  description = "The name of the resource group for bookstore"
  type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "The location of the resource group for bookstore"
  type = string
}