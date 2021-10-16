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

variable "cosmos_endpoint_key_name" {
  default = "MyHealth:CosmosEndpoint"
}