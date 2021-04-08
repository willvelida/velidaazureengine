variable "resource_group_name" {
  default = "myhealthexceptions-rg"
  description = "Name of the Resource Group used for MyHealth.Exceptions"
  type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "Location used for the resource group for MyHealth.Exceptions"
  type = string
}

variable "function_storage_name" {
  default = "samyhealthexceptions"
  description = "Name of the storage account for MyHealth.Exceptions"
  type = string
}

variable "myhealth_app_service_plan" {
  default = "myhealthappserviceplan"
  description = "Name of the App Service Plan for MyHealth"
  type = string
}

variable "myhealth_resource_group" {
  default = "myhealth-rg"
  description = "The name of the resource group for MyHealth"
  type = string
}

variable "myhealth_exceptions_function_name" {
  default = "famyhealthexceptions"
  description = "Name of the MyHealth.Exceptions App"
  type = string
}