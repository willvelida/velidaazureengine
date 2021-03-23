terraform {
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "cosmostfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

data "azurerm_key_vault" "keyvault" {
  name = "willvelidakeyvault"
  resource_group_name = "velidaazureengine-rg"
}

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

  geo_location {
      location = var.cosmos_failover_location
      failover_priority = 1
  }

  analytical_storage_enabled = true

  consistency_policy {
    consistency_level = "Session"
  }
}

resource "azurerm_key_vault_secret" "cosmosdbconnectionstring" {
  name = var.cosmos_db_connection_string_secret
  value = azurerm_cosmosdb_account.db.connection_strings[0]
  key_vault_id = data.azurerm_key_vault.keyvault.id
}