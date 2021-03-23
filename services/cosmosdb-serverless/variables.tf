variable "resource_group_name" {
    default = "velidacosmosserverlessdb-rg"
    description = "Name of the resource group"
    type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "Location of the resource group"
  type = string
}

variable "cosmos_account_name" {
  default = "willvelidaserverlesscosmosdb"
  description = "Name given to the Cosmos DB account"
  type = string
}

variable "external_resource_group_name" {
  default = "velidaazureengine-rg"
  description = "Name of the external resource group"
  type = string
}