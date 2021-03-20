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

resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.resource_group_location
}

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

resource "azurerm_cosmosdb_sql_database" "container" {
  name = var.cosmos_database_name
  resource_group_name = var.resource_group_name
  account_name = var.cosmos_account_name
  autoscale_settings {
    max_throughput = 4000
  }
}