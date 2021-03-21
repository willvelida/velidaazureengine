variable "resource_group_name" {
  description = "Name of the resource group"
  type = string
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type = string
}

variable "resource_group_tags" {
  description = "Tags to set on the response group. (Optional)"
  type = map(string)
  default = {}
}