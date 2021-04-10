terraform {
    backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthfilevalidatoractivitytfstate"
      key = "terraform.tfstate"
    }
}

provider "azurerm" {
  version = "~>2.0"
  features {}
}

# Create Resource Group
module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "false"
        "ApplicationName" = "MyHealth"
        "ServiceName" = "MyHealth.FileValidator.Activity"
    }  
}

# Import Key Vault
data "azurerm_key_vault" "velidakeyvault" {
    name = var.velida_key_vault
    resource_group_name = var.velida_resource_group_name
}

# Import App Service Plan
data "azurerm_app_service_plan" "appplan" {
    name = var.myhealth_app_service_plan
    resource_group_name = var.myhealth_resource_group
}

# Import Service Bus Namespace
data "azurerm_servicebus_namespace" "myhealthsb" {
  name = var.service_bus_namespace
  resource_group_name = var.velida_resource_group_name
}

# Create storage account for MyHealth.FileValidator.Activity
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

# Create Function App for MyHealth.FileValidator.Activity
resource "azurerm_function_app" "myhealthexceptions" {
  name = var.myhealth_filevalidator_activity_function_name
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  app_service_plan_id = data.azurerm_app_service_plan.appplan.id
  storage_account_name = module.storage_account.storage_account_name
  storage_account_access_key = module.storage_account.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [app_settings]
  }
}

# Create Key Vault Access Policy for Key Vault
resource "azurerm_key_vault_access_policy" "velidakeyvault_policy" {
  key_vault_id = data.azurerm_key_vault.velidakeyvault.id
  tenant_id = var.tenant_id
  object_id = azurerm_function_app.myhealthexceptions.identity[0].principal_id
  secret_permissions = [ "get","list" ]
}

# Create Activity Topic in Service Bus Namespace
module "activity_sb_topic" {
    source = "../../modules/service_bus_topic"
    topic_name = var.activity_topic_name
    topic_resource_group = data.azurerm_servicebus_namespace.myhealthsb.resource_group_name
    topic_namespace = data.azurerm_servicebus_namespace.myhealthsb.name   
}