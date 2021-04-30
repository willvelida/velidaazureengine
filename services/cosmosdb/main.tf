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

  analytical_storage_enabled = true

  consistency_policy {
    consistency_level = "Session"
  }
}

# Adding Cosmos DB Secrets to Key Vault
resource "azurerm_key_vault_secret" "cosmosdbconnectionstring" {
  name = var.cosmos_db_connection_string_secret
  value = azurerm_cosmosdb_account.db.connection_strings[0]
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmosdbendpoint" {
  name = var.cosmos_db_endpoint
  value = azurerm_cosmosdb_account.db.endpoint
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmosdbprimarykey" {
  name = var.cosmos_db_primary_key
  value = azurerm_cosmosdb_account.db.primary_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# Adding metrics to Log Analytics
resource "azurerm_monitor_diagnostic_setting" "cosmosdbdiagnostics" {
  name = var.cosmos_log_analytics_settings
  target_resource_id = azurerm_cosmosdb_account.db.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.loganalytics.id

  log {
    category = "DataPlaneRequests"
    enabled = true
  }

  log {
    category = "QueryRuntimeStatistics"
    enabled = true
  }

  log {
    category = "PartitionKeyStatistics"
    enabled = true
  }

  log {
    category = "PartitionKeyRUConsumption"
    enabled = true
  }

  log {
    category = "ControlPlaneRequests"
    enabled = true
  }

  metric {
    category = "Requests"
    enabled = true
  }
}