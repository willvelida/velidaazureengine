resource "azurerm_application_insights" "this" {
  name = var.app_insights_name
  location = var.app_insights_location
  resource_group_name = var.app_insights_rg
  application_type = var.app_type
}