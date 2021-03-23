output "service_bus_namespace_id" {
  description = "The Service Bus Namespace ID"
  value = azurerm_servicebus_namespace.this.id
}

output "service_bus_namespace_name" {
  description = "Name of the Service Bus"
  value = azurerm_servicebus_namespace.this.name
}