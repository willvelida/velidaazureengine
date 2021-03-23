terraform {
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "cosmosserverlesstfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

# Referencing key vault into terraform file
data "azurerm_key_vault" "keyvault" {
  name = "willvelidakeyvault"
  resource_group_name = var.external_resource_group_name
}

# Referencing Log Analytics into terraform file
data "azurerm_log_analytics_workspace" "loganalytics" {
  name = "velidaloganalytics"
  resource_group_name = var.external_resource_group_name
}

# Reusing the resource_group module
module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "true"
        "Resource-Type" = "AzureCosmosDB"
    }
}

# Creating our Cosmos DB account
resource "azurerm_cosmosdb_account" "db" {
  name = var.cosmos_account_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  offer_type = "Standard"
  kind = "GlobalDocumentDB"
  enable_automatic_failover = true

  geo_location {
      location = module.resource_group.location
      failover_priority = 0
  }

  consistency_policy {
    consistency_level = "Session"
  }

  capabilities {
    name = "EnableServerless"
  }
}

