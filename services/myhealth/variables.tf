variable "resource_group_name" {
  default = "myhealth-rg"
  description = "Name of the resource group used for MyHealth"
  type = string 
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "Location used for the resource group for MyHealth"
  type = string
}

variable "cosmos_db_account_name" {
  default = "willvelidacosmosdb"
}

variable "cosmos_db_resource_group_name" {
  default = "velidacosmosdb-rg"
}

variable "velida_generic_resource_group_name" {
  default = "velidaazureengine-rg"
}

variable "common_storage_account" {
  default = "velidastorage"
}

variable "myhealth_db_name" {
  default = "MyHealthDB"
}

variable "myhealth_container_name" {
  default = "Records"
}

variable "exception_topic_name" {
  default = "myhealthexceptiontopic"
}

variable "service_bus_namespace" {
  default = "velidaservicebus"
}

variable "exception_subscription_name" {
  default = "myhealthexceptionsubscription"
}

variable "myhealth_app_service_plan_name" {
  default = "myhealthappserviceplan"
}

variable "system_topic_name" {
  default = "egmyhealth"
}

variable "filewatcher_activity_function_name" {
  default = "famyhealthfilevalidatoractivity"
}

variable "filewatcher_activity_function_rg" {
  default = "myhealthfilevalidatoractivity-rg"
}

variable "activity_event_subscription" {
  default = "myhealthfwactivitysubscription"
}