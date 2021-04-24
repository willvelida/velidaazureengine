terraform {
    backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthdbsinkactivitytfstate"
      key = "terraform.tfstate"
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
        "ServiceName" = "MyHealth.DBSink.Activity"
    }  
}