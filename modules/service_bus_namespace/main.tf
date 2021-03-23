resource "azurerm_servicebus_namespace" "this" {
    name = var.service_bus_namespace_name
    location = var.service_bus_namespace_location
    resource_group_name = var.service_bus_resource_group
    sku = "Standard"
    tags = var.service_bus_tags
}