variable "resource_group_name" {
  default = "myhealthdbsinkactivity-rg"
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
  default = "samyhealthdbsinkactivity"
  description = "Name of the storage account for MyHealth.DBSink.Activity"
  type = string
}

variable "myhealth_dbsink_activity_function_name" {
  default = "famyhealthdbsinkactivity"
  description = "Name of the MyHealth.DBSink.Activity App"
  type = string
}

variable "tenant_id" {
  default = "e60bb76c-8fda-4ed4-a354-4836e3bfcbc3"
}