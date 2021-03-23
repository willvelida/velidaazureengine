variable "topic_name" {
  description = "Name of the topic"
  type = string
}

variable "topic_resource_group" {
  description = "Name of the resource group to provision the topic"
  type = string
}

variable "topic_namespace" {
  description = "The namespace to provision the topic to"
  type = string
}