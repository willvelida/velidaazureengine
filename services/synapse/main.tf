terraform {
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "synapsetfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

# Reusing the resource_group module
module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "true"
        "Resource-Type" = "AzureSynapse"
    }
}

# Creating the Gen2 Filesystem
module "storage_account" {
  source = "../../modules/storage_account"
  storage_account_name = var.storage_account_name
  resource_group_name = module.resource_group.name
  storage_location = module.resource_group.location
  account_tier = "Standard"
  account_replication_type = "GRS"
  account_kind = "StorageV2"
  is_hns_enabled = "true"

  storage_account_tags = {
    "Environment" = "Dev"
    "MainAzureEngineResource" = "False"
  }
}

module "data_lake_gen2_filesystem" {
    source = "../../modules/data_lake_gen2_filesystem"
    file_system_name = var.file_system_name
    storage_account_id = module.storage_account.storage_account_id
}

# Creating the Synapse Workspace
resource "azurerm_synapse_workspace" "synapse" {
    name = var.synapse_workspace_name
    resource_group_name = module.resource_group.name
    location = module.resource_group.location
    storage_data_lake_gen2_filesystem_id = module.data_lake_gen2_filesystem.filesystem_id
    sql_administrator_login = "willvelida"
    sql_administrator_login_password = "Seacow2019Toby9!"
}