terraform {
    backend "azure" {
      resource_group_name = "velidarg"
      storage_account_name = "velidaterraform"
      container_name = "myhealthapimtfstate"
      key = "terraform.tfstate"
    }
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.48.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Import App Insights
data "azure_application_insights" "appinsights" {
    name = var.app_insights_name
    resource_group_name = var.app_insights_resource_group
}

# Import API Management Instance
data "azurerm_api_management" "apim" {
  name = var.api_name
  resource_group_name = var.api_resource_group_name
}

# Linked APIM to App Insights
resource "azurerm_api_management_logger" "apilogger" {
  name = var.api_logger_name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  application_insights {
    instrumentation_key = data.azurerm_application_insights.appinsights.application_insights_instrumentation_key
  }
}