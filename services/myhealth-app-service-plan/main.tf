terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "2.46.0"
        }
    }
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "samyhealthappplan"
      container_name = "myhealthappplantfstate"
      key = "myhealthappplan.tfstate"
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
        "ApplicationName" = "MyHealth"
    }
}

resource "azurerm_app_service_plan" "myhealthplan" {
    name = var.myhealth_app_service_plan_name
    location = module.resource_group.location
    resource_group_name = module.resource_group.name
    kind = "Linux"
    reserved = true
    sku {
        tier = "Dynamic"
        size = "Y1"
    }
}