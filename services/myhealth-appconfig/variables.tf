variable "resource_group_name" {
  default = "myhealthappconfig-rg"
}

variable "resource_group_location" {
  default = "australiaeast"
}

variable "app_config" {
  default = "myhealthappconfig"
}

variable "key_vault_name" {
  default = "willvelidakeyvault"
}

variable "external_resource_group_name" {
  default = "velidaazureengine-rg"
}

variable "cosmosendpoint_secret" {}

variable "service_bus_connection" {}

variable "cosmos_endpoint_key_name" {
  default = "MyHealth:CosmosEndpoint"
}

variable "service_bus_key_name" {
  default = "VelidaEngine:ServiceBusConnectionString"
}

variable "myhealthdb_key" {
  default = "MyHealth:DatabaseName"
}

variable "cosmos_connection_key_name" {
  default = "MyHealth:CosmosDBConnectionString"
}

variable "comsosconnection_secret" {}

variable "myhealthdb_value" {
  default = "MyHealthDB"
}

variable "myhealthcontainer_key" {
  default = "MyHealth:RecordsContainer"
}

variable "myhealthcontainer_value" {
  default = "Records"
}

variable "exceptionqueue_key" {
  default = "MyHealth:ExceptionQueue"
}

variable "exceptionqueue_value" {
  default = "myhealthexceptionqueue"
}

variable "myhealth_appconfig_endpoint" {}