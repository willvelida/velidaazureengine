variable "system_topic_name" {
  description = "The name of the Event Grid System Topic"
  type = string
}

variable "resource_group_name" {
  description = "The resource group to deploy the Event Grid System Topic to"
  type = string
}

variable "location" {
  description = "The location to deploy the Event Grid System Topic to"
  type = string
}

variable "source_arm_resource_id" {
    description = "The ID of the Event Grid System Topic ARM source."
    type = string
}

variable "topic_type" {
  description = "The Topic Type of the Event Grid System Topic"
  type = string
}

variable "tags" {
  description = "Tags belonging to the Event Grid System Topic"
  type = map(string)
  default = {}
}