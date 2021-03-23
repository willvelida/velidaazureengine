output "service_bus_namespace_id" {
  description = "The Service Bus Namespace ID"
  value = azurerm_servicebus_namespace.this.id
}