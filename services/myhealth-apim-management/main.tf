terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>2.0"
      }
    }
    backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthapimtfstate"
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
        "Resource-Specific" = "true"
        "ApplicationName" = "MyHealth"

    }  
}

resource "azurerm_api_management" "apim" {
  name = var.myhealth_apim_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  publisher_name = var.myhealth_publisher_name
  publisher_email = var.myhealth_publisher_email

  sku_name = "Developer_1"
}