resource "azurerm_servicebus_topic" "this" {
  name = var.topic_name
  resource_group_name = var.topic_resource_group
  namespace_name = var.topic_namespace
}