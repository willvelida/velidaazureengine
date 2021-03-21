resource "azurerm_resource_group" "this" {
  name = var.resource_group_name
  location = var.resource_group_location
  tags = var.resource_group_tags
}