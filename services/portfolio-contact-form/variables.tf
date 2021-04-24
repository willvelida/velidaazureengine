variable "resource_group_name" {
  default = "portfoliosite-rg"
  description = "The name of the resource group for bookstore"
  type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "The location of the resource group for bookstore"
  type = string
}

variable "velida_key_vault" {
  default = "willvelidakeyvault"
}

variable "velida_resource_group_name" {
  default = "velidaazureengine-rg"
}

variable "contactform_app_service_plan_name" {
  default = "aspvelidaportfoliosite"
}

variable "function_storage_name" {
  default = "savelidapscontact"
  description = "Name of the storage account for Portfolio.ContactForm"
  type = string
}

variable "portfolio_contactform_function_name" {
  default = "favelidapscontact"
  description = "Name of the Portfolio.ContactForm App"
  type = string
}

variable "tenant_id" {
  default = "e60bb76c-8fda-4ed4-a354-4836e3bfcbc3"
}