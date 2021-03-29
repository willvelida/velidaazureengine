terraform {
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "bookstoretfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

# Creating the resource group for Bookstore
module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "false"
        "ApplicationName" = "VelidaBookstore"
    }
}

# Creating the storage account for the Bookstore API
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

## Creating the app service plan
resource "azurerm_app_service_plan" "asp" {
    name = var.app_service_plan_name
    location = module.resource_group.location
    resource_group_name = module.resource_group.name
    kind = "FunctionApp"

    sku {
        tier = "Dynamic"
        size = "Y1"
    }
}

## Deploying the Bookstore API function app
resource "azurerm_function_app" "bookstoreapi" {
    name = var.bookstore_api_function_name
    location = module.resource_group.location
    resource_group_name = module.resource_group.name
    app_service_plan_id = azurerm_app_service_plan.asp.id
    storage_account_name = module.storage_account.storage_account_name
    storage_account_access_key = module.storage_account.primary_access_key
}