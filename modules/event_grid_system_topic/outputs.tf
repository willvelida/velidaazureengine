output "event_grid_system_topic_id" {
  description = "The ID of the Event Grid System Topic"
  value = azurerm_eventgrid_system_topic.this.id 
}

output "metric_arm_resource_id" {
  description = "The Metric ARM Resource ID of the Event Grid System Topic"
  value = azurerm_eventgrid_system_topic.this.metric_arm_resource_id
}