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
      container_name = "myhealthappconfigtfstate"
      key = "terraform.tstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_key_vault" "keyvault" {
  name = var.key_vault_name
  resource_group_name = var.external_resource_group_name
}

data "azurerm_key_vault_secret" "cosmosendpoint" {
  name = var.cosmosendpoint_secret
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "servicebusconnectionstring" {
  name = var.service_bus_connection
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_client_config" "current" {}

module "resource_group" {
    source = "../../modules/resource_group"
    resource_group_name = var.resource_group_name
    resource_group_location = var.resource_group_location
    resource_group_tags = {
        "Terraform" = "true"
        "Resource-Specific" = "true"
        "Resource-Type" = "AppConfiguration"
        "ApplicationName" = "MyHealth"
    }
}

resource "azurerm_role_assignment" "appconf_dataowner" {
  scope = azurerm_app_configuration.appconfig.id
  role_definition_name = "App Configuration Data Owner"
  principal_id = data.azurerm_client_config.current.object_id
}

resource "azurerm_app_configuration" "appconfig" {
  name = var.app_config
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  sku = "free"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_app_configuration_key" "cosmosendpointkey" {
    configuration_store_id = azurerm_app_configuration.appconfig.id
    vault_key_reference = data.azurerm_key_vault_secret.cosmosendpoint.id
    type = "vault"
    key = var.cosmos_endpoint_key_name

    depends_on = [
      azurerm_role_assignment.appconf_dataowner
    ]
}

resource "azurerm_app_configuration_key" "servicebuskey" {
  configuration_store_id = azurerm_app_configuration.appconfig.id
  vault_key_reference = data.azurerm_key_vault_secret.servicebusconnectionstring.id
  type = "vault"
  key = var.service_bus_key_name

  depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]
}