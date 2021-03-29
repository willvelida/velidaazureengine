variable "resource_group_name" {
  default = "velidabookstore-rg"
  description = "The name of the resource group for bookstore"
  type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "The location of the resource group for bookstore"
  type = string
}

variable "function_storage_name" {
  default = "savelidabookstoreapi"
  description = "Name of the storage account for the function app"
  type = string
}

variable "app_service_plan_name" {
  default = "aspvelidabookstore"
  description = "Name of the App Service Plan for Bookstore"
  type = string
}

variable "bookstore_api_function_name" {
  default = "favelidabookstoreapi"
  description = "Name of the Function App for Bookstore API"
  type = string
}