variable "resource_group_name" {
  default = "myhealthfitbitsleep-rg"
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
  default = "myhealth-appserviceplan-rg"
  description = "Name of the App Service Plan for MyHealth"
  type = string
}

variable "myhealth_resource_group" {
  default = "myhealth-rg"
  description = "The name of the resource group for MyHealth"
  type = string
}

variable "function_storage_name" {
  default = "samyhealthfitbitsleep"
  description = "Name of the storage account for MyHealth.Fitbit.Sleep"
  type = string
}

variable "myhealth_fitbit_sleep_function_name" {
  default = "famyhealthfitbitsleep"
  description = "Name of the MyHealth.Fitbit.Sleep App"
  type = string
}

variable "tenant_id" {
  default = "e60bb76c-8fda-4ed4-a354-4836e3bfcbc3"
}