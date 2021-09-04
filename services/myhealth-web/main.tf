terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "=2.75.0"
      }
    }
    backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthwebtfstate"
      key = "terraform.tfstate"
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
        "ApplicationName" = "MyHealth"
        "ServiceName" = "MyHealth.Web"
    }  
}

resource "azurerm_static_site" "myhealthweb" {
  name = var.website_name
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  sku_size = var.sku_size
}