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
      container_name = "myhealthdbtfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  features {}
}

# Referencing key vault into terraform file
data "azurerm_key_vault" "keyvault" {
  name = var.key_vault_name
  resource_group_name = var.external_resource_group_name
}

data "azurerm_log_analytics_workspace" "loganalytics" {
  name = var.log_analytics_workspace
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
        "ApplicationName" = "MyHealth"
    }
}

# Cosmos DB Account
resource "azurerm_cosmosdb_account" "account" {
  name = var.myhealth_cosmos_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  offer_type = "Standard"
  kind = "GlobalDocumentDB"

  public_network_access_enabled = false
  ip_range_filter = var.ip_rules

  local_authentication_disabled = false

  enable_automatic_failover = true

  geo_location {
    location = module.resource_group.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
      consistency_level = "Session"
  }

  backup {
    type = "Continuous"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Database for sql
resource "azurerm_cosmosdb_sql_database" "db" {
  name = var.myhealth_sql_db_name
  account_name = azurerm_cosmosdb_account.account.name
  resource_group_name = module.resource_group.name
}

# Container for SQL
resource "azurerm_cosmosdb_sql_container" "container" {
  name = var.myhealth_sql_container_name
  resource_group_name = module.resource_group.name
  account_name = azurerm_cosmosdb_account.account.name
  database_name = azurerm_cosmosdb_sql_database.db.name
  partition_key_path = "/DocumentType"

  indexing_policy {
   indexing_mode = "Consistent"

   included_path {
     path = "/*"
   }
  }
}

# Adding Cosmos DB Secrets to Key Vault
resource "azurerm_key_vault_secret" "cosmosdbconnectionstring" {
  name = var.myhealth_connection_string_secret
  value = azurerm_cosmosdb_account.account.connection_strings[0]
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmosendpoint" {
 name = var.myhealth_db_endpoint
 value = azurerm_cosmosdb_account.account.endpoint
 key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmosreadendpoint" {
  name = var.myhealth_db_read_endpoint
  value = azurerm_cosmosdb_account.account.read_endpoints[0]
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmoswriteendpoint" {
  name = var.myhealth_db_write_endpoint
  value = azurerm_cosmosdb_account.account.write_endpoints[0]
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmosprimarykey" {
  name = var.myhealth_db_primary_key
  value = azurerm_cosmosdb_account.account.primary_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmossecondarykey" {
  name = var.myhealth_db_secondary_key
  value = azurerm_cosmosdb_account.account.secondary_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmosprimaryreadonlykey" {
  name = var.myhealth_db_primary_readonly_key
  value = azurerm_cosmosdb_account.account.primary_readonly_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmossecondaryreadonlykey" {
  name = var.myhealth_db_secondary_readonly_key
  value = azurerm_cosmosdb_account.account.secondary_readonly_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

# Adding Metris to Log Analytics
resource "azurerm_monitor_diagnostic_setting" "cosmosdbdiagnostics" {
  name = var.myhealth_diagnostics_settings
  target_resource_id = azurerm_cosmosdb_account.account.id
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