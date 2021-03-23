output "topic_name" {
  description = "The name of the topic"
  value = azurerm_servicebus_topic.this.name
}