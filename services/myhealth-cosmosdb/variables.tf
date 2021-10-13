variable "key_vault_name" {
  default = "willvelidakeyvault"
}

variable "external_resource_group_name" {
  default = "velidaazureengine-rg"
}

variable "resource_group_name" {
    default = "myhealthdb-rg"
    description = "Name of the resource group"
    type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "Location of the resource group"
  type = string
}

variable "myhealth_cosmos_name" {
  default = "myhealthplatform"
}

variable "myhealth_sql_db_name" {
  default = "MyHealthDB"
}

variable "myhealth_sql_container_name" {
  default = "Records"
}

variable "log_analytics_workspace" {
  default = "velidaloganalytics"
}

variable "myhealth_connection_string_secret" {
  default = "myhealthcosmosconnectionstring"
}

variable "myhealth_db_endpoint" {
  default = "myhealthcosmosendpoint"
}

variable "myhealth_db_primary_key" {
  default = "myhealthprimarykey"
}

variable "myhealth_diagnostics_settings" {
  default = "myhealth_cosmos_diagnostics"
}