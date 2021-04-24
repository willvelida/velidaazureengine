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

# Create an event grid topic for that storage account
module "myhealth_eventgrid_system_topic" {
  source = "../../modules/event_grid_system_topic"
  system_topic_name = var.system_topic_name
  resource_group_name = var.velida_generic_resource_group_name
  location = module.resource_group.location
  source_arm_resource_id = data.azurerm_storage_account.velidastorage.id
  topic_type = "Microsoft.Storage.StorageAccounts"
  tags = {
    "Terraform" = "true"
    "Resource-Specific" = "false"
    "ApplicationName" = "MyHealth"
  }
}

# Import MyHealth.FileWatcher.Activity Function
data "azurerm_function_app" "filewatcher_activity" {
  name = var.filewatcher_activity_function_name
  resource_group_name = var.filewatcher_activity_function_rg 
}

# Create Subscription using MyHealth.FileWatcher.Activity
resource "azurerm_eventgrid_system_topic_event_subscription" "activitysub" {
  name = var.activity_event_subscription
  system_topic = module.myhealth_eventgrid_system_topic.system_topic_name
  resource_group_name = var.velida_generic_resource_group_name

  subject_filter {
    subject_begins_with = "/blobServices/default/containers/myhealthfiles/activity"
  }

  azure_function_endpoint {
    function_id = "${data.azurerm_function_app.filewatcher_activity.id}/functions/ValidateActivityFile"
  }
}