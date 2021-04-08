terraform {
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthexceptionstfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

# Creating the resource group for MyHealth.Exceptions
module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "false"
        "ApplicationName" = "MyHealth"
        "ServiceName" = "MyHealth.Exceptions"
    }
}

# Importing the App Service Plan
data "azurerm_app_service_plan" "appplan" {
    name = var.myhealth_app_service_plan
    resource_group_name = var.myhealth_resource_group
}

# Creating the storage account for MyHealth.Exceptions
module "storage_account" {
    source = "../../modules/storage_account"
    storage_account_name = var.function_storage_name
    resource_group_name = module.resource_group.name
    storage_location = module.resource_group.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
    is_hns_enabled = "false"
}

# Creating the function app for MyHealth.Exceptions
resource "azurerm_function_app" "myhealthexceptions" {
  name = var.myhealth_exceptions_function_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  app_service_plan_id = data.azurerm_app_service_plan.appplan.id
  storage_account_name = module.storage_account.storage_account_name
  storage_account_access_key = module.storage_account.primary_access_key
}
