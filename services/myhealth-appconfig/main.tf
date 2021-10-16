terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.0"
      }
    }
  backend "azurerm" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthappconfigtfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "true"
        "Resource-Type" = "AppConfiguration"
        "ApplicationName" = "MyHealth"
    }
}

resource "azurerm_app_configuration" "appconfig" {
  name = var.app_config
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  sku = "free"

  identity {
    type = "SystemAssigned"
  }
}