variable "service_bus_namespace_name" {
  description = "Name of the Service Bus namespace"
  type = string
}

variable "service_bus_namespace_location" {
  description = "Location to provision the Service Bus Namespace"
  type = string
}

variable "service_bus_resource_group" {
  description = "The Resource Group to provision the Service Bus Namespace to"
  type = string
}

variable "service_bus_tags" {
  description = "Tags to add to the Service Bus Namespace"
  default = {}
  type = map(string)
}