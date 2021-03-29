variable "app_insights_name" {
  description = "Name of the application insights instance"
  type = string
}

variable "app_insights_location" {
  description = "Location to deploy the app insights instance"
  type = string
}

variable "app_insights_rg" {
  description = "The resource group to deploy the app insights instance to"
  type = string
}

variable "app_type" {
  description = "Specifies the type of App Insights to create"
  type = string
}