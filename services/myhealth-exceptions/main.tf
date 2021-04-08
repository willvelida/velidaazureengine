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