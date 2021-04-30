terraform {
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthtfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "false"
        "ApplicationName" = "MyHealth"
    }
}

# Create App Service Plan for all MyHealth Function Apps
resource "azurerm_app_service_plan" "myhealthplan" {
  name = var.myhealth_app_service_plan_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  kind = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

data "azurerm_cosmosdb_account" "account" {
    name = var.cosmos_db_account_name
    resource_group_name = var.cosmos_db_resource_group_name
}

data "azurerm_servicebus_namespace" "namespace" {
  name = var.service_bus_namespace
  resource_group_name = var.velida_generic_resource_group_name
}

# Create Exception Queue
resource "azurerm_servicebus_queue" "exceptionqueue" {
  name = var.exception_queue_name
  resource_group_name = var.velida_generic_resource_group_name
  namespace_name = var.service_bus_namespace
}

# Import Activity Topic
data "azurerm_servicebus_topic" "topic" {
  name = var.activity_topic_name
  resource_group_name = var.velida_generic_resource_group_name
  namespace_name = var.service_bus_namespace
}

# Create Subscription to Activity Topic
resource "azurerm_servicebus_subscription" "activitysubscription" {
  name = var.activity_subscription_name
  resource_group_name = var.velida_generic_resource_group_name
  namespace_name = var.service_bus_namespace
  topic_name = var.activity_topic_name
  max_delivery_count = 10
}

# Import Sleep Topic
data "azurerm_servicebus_topic" "sleeptopic" {
  name = var.sleep_topic_name
  resource_group_name = var.velida_generic_resource_group_name
  namespace_name = var.service_bus_namespace
}

# Create Subscription to Sleep Topic
resource "azurerm_servicebus_subscription" "sleepsubscription" {
  name = var.sleep_subscription_name
  resource_group_name = var.velida_generic_resource_group_name
  namespace_name = var.service_bus_namespace
  topic_name = var.sleep_topic_name
  max_delivery_count = 10
}

# Create Database for MyHealth
resource "azurerm_cosmosdb_sql_database" "db" {
  name = var.myhealth_db_name
  resource_group_name = data.azurerm_cosmosdb_account.account.resource_group_name
  account_name = data.azurerm_cosmosdb_account.account.name
}

# Import the storage account
data "azurerm_storage_account" "velidastorage" {
  name = var.common_storage_account
  resource_group_name = var.velida_generic_resource_group_name
}

# Create DuplicateFiles Storage Table
resource "azurerm_storage_table" "activityfileduplicate" {
  name = var.file_duplicate_table_name
  storage_account_name = data.azurerm_storage_account.velidastorage.name
}