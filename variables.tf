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

variable "cosmos_account_name" {
  description = "Name of the Cosmos DB account"
  type = string
  default = "willvelidacosmosdb"
}

variable "storage_account_name" {
  default = "velidastorage"
  description = "Name of the Storage account"
  type = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  default = "willvelidakeyvault"
  type = string
}

variable "log_analytics_name" {
  description = "Name of the Log Analytics"
  default = "velidaloganalytics"
  type = string
}

variable "cosmos_log_analytic_setting" {
  description = "Name of the diagnostic log settings for Cosmos DB"
  default = "cosmosdb_loganalytics_diagnostic_settings"
  type = string
}

variable "api_management_name" {
  description = "Name of the API Management Instance"
  default = "velidaapimanagement"
  type = string
}