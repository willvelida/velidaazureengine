terraform {
  backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "portfoliocontactformtfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

# Create resource group
module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "false"
        "ApplicationName" = "Portfolio-Site"
        "Service-Name" = "Portfolio.ContactForm"
    }
}

# Importing Key Vault
data "azurerm_key_vault" "velidakeyvault" {
  name = var.velida_key_vault
  resource_group_name = var.velida_resource_group_name
}

# Create App Service Plan for all MyHealth Function Apps
resource "azurerm_app_service_plan" "portfoliositeplan" {
  name = var.contactform_app_service_plan_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  kind = "FunctionApp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

# Creating the storage account for Portfolio.ContactForm
module "storage_account" {
    source = "../../modules/storage_account"
    storage_account_name = var.function_storage_name
    resource_group_name = module.resource_group.name
    storage_location = module.resource_group.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"
    is_hns_enabled = "false"
}

# Creating the function app for Portfolio.ContactForm
resource "azurerm_function_app" "portfoliocontactform" {
  name = var.portfolio_contactform_function_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.portfoliositeplan.id
  storage_account_name = module.storage_account.storage_account_name
  storage_account_access_key = module.storage_account.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [app_settings]
  }
}

resource "azurerm_key_vault_access_policy" "velidakeyvault_policy" {
  key_vault_id = data.azurerm_key_vault.velidakeyvault.id
  tenant_id = azurerm_function_app.portfoliocontactform.identity[0].tenant_id
  object_id = azurerm_function_app.portfoliocontactform.identity[0].principal_id
  secret_permissions = [ "get","list" ]
}