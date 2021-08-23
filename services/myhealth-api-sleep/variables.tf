variable "resource_group_name" {
  default = "myhealthapisleep-rg"
}

variable "resource_group_location" {
  default = "australiaeast"
}

variable "velida_key_vault" {
  default = "willvelidakeyvault"
}

variable "velida_resource_group_name" {
  default = "velidaazureengine-rg"
}

variable "myhealth_app_service_plan" {
  default = "myhealthappplan"
  description = "Name of the App Service Plan for MyHealth"
  type = string
}

variable "myhealth_app_resource_group" {
  default = "myhealth-appserviceplan-rg"
  description = "The name of the resource group for MyHealth"
  type = string
}

variable "function_storage_name" {
  default = "samyhealthapisleep"
  description = "Name of the storage account for MyHealth.API.Sleep"
  type = string
}

variable "myhealth_api_sleep_function_name" {
  default = "famyhealthapisleep"
  description = "Name of the MyHealth.API.Sleep App"
  type = string
}

variable "tenant_id" {
  default = "e60bb76c-8fda-4ed4-a354-4836e3bfcbc3"
}