terraform {
    backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "tstate"
      key = "terraform.tfstate"
    }
}

data "azurerm_client_config" "current" {}

provider "azurerm" {
  version = "~>2.0"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

## Velida Azure Engine Resource Group
module "resource_group" {
  source = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
  resource_group_tags = {
    "Terraform" = "true"
    "Environment" = "Dev"
  }
}

## Azure Cosmos DB Account
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

## Storage Account
resource "azurerm_storage_account" "storage" {
  name = var.storage_account_name
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  account_tier = "Standard"
  account_replication_type = "GRS"
}

# Key Vault
resource "azurerm_key_vault" "keyvault" {
  name = var.key_vault_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  enabled_for_disk_encryption = true
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7

  access_policy  {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "Set",
      "List"
    ]

    key_permissions = [
      "List",
      "Get",
      "Create"
    ]
  }
}

# Azure Log Analytics
resource "azurerm_log_analytics_workspace" "logs" {
  name = var.log_analytics_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  sku = "PerGB2018"
  retention_in_days = 30
}