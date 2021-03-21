variable "storage_container_name" {
  description = "The name of the container"
  type = string
}

variable "storage_account_name" {
  description = "Name of the storage account to provision the container in"
  type = string
}

variable "container_access_type" {
  description = "The Access Level configured for the container"
  type = string
}