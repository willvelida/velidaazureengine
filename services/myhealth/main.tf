terraform {
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthtfstate"
      key = "terraform.tstate"
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
    }
}

data "azurerm_cosmosdb_account" "account" {
    name = var.cosmos_db_account_name
    resource_group_name = var.velida_engine_resource_group_name
}

# Create Database for MyHealth
resource "azurerm_cosmosdb_sql_database" "db" {
  name = var.myhealth_db_name
  resource_group_name = data.azurerm_cosmosdb_account.account.resource_group_name
  account_name = data.azurerm_cosmosdb_account.account.name
}

# Create Containers for MyHealth in Cosmos DB
resource "azurerm_cosmosdb_sql_container" "container" {
    name = var.myhealth_container_name
    resource_group_name = data.azurerm_cosmosdb_account.account.resource_group_name
    account_name = data.azurerm_cosmosdb_account.account.name
    database_name = azurerm_cosmosdb_sql_database.db.name
    partition_key_path = "/DocumentType"
    autoscale_settings {
        max_throughput = 4000
    }
}