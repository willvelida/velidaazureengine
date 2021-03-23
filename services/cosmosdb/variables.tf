variable "resource_group_name" {
    default = "velidacosmosdb-rg"
    description = "Name of the resource group"
    type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "Location of the resource group"
  type = string
}

variable "cosmos_account_name" {
  default = "willvelidacosmosdb"
  description = "Name given to the Cosmos DB account"
  type = string
}

variable "cosmos_failover_location" {
  default = "australiasoutheast"
  description = "The failover location for the Cosmos DB account"
  type = string
}

variable "cosmos_db_connection_string_secret" {
  default = "cosmosdbconnectionstring"
  description = "Name of the secret for the Cosmos DB Connection String"
  type = string
}

variable "external_resource_group_name" {
  default = "velidaazureengine-rg"
  description = "Name of the external resource group"
  type = string
}

variable "cosmos_log_analytics_settings" {
  description = "Name of the diagnostic log settings for Cosmos DB"
  default = "cosmosdb_loganalytics_diagnostic_settings"
  type = string
}