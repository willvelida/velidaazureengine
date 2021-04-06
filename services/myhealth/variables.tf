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

variable "cosmos_db_account_name" {
  default = "willvelidacosmosdb"
}

variable "velida_engine_resource_group_name" {
  default = "velidacosmosdb-rg"
}

variable "myhealth_db_name" {
  default = "MyHealthDB"
}

variable "myhealth_container_name" {
  default = "Records"
}