variable "resource_group_name" {
  description = "Name of the resource group"
  type = string
  default = "velidaazureengine-rg"
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type = string
  default = "australiaeast"
}

variable "cosmos_failover_location" {
  description = "Cosmos DB Failover location"
  type = string
  default = "australiasoutheast"
}