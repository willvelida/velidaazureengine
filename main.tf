terraform {
    backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "tstate"
      key = "terraform.tfstate"
    }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

## Velida Azure Engine Resource Group
resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.resource_group_location
}

## Azure Cosmos DB Account
resource "azurerm_cosmosdb_account" "db" {
  name = var.cosmos_account_name
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  offer_type = "Standard"
  kind = "GlobalDocumentDB"
  enable_automatic_failover = true
  
  geo_location {
    location = var.resource_group_location
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
  resource_group_name = var.resource_group_name
  location = var.resource_group_location
  account_tier = "Standard"
  account_replication_type = "GRS"
}

