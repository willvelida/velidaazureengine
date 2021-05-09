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

variable "activity_topic_name" {
  default = "myhealthactivitytopic"
}

variable "sleep_topic_name" {
  default = "myhealthsleeptopic"
}

variable "service_bus_namespace" {
  default = "velidaservicebus"
}

variable "activity_subscription_name" {
  default = "myhealthactivitysubscription"
}

variable "sleep_subscription_name" {
  default = "myhealthsleepsubscription"
}

variable "nutrition_topic_name" {
  default = "myhealthnutritiontopic"
}

variable "nutrition_subscription_name" {
  default = "myhealthnutritionsubscription"
}

variable "myhealth_app_service_plan_name" {
  default = "myhealthappserviceplan"
}

variable "file_duplicate_table_name" {
  default = "DuplicateFiles"
}

variable "exception_queue_name" {
  default = "myhealthexceptionqueue"
}