variable "storage_account_name" {
  description = "Name of the storage account (must be unique)"
  type = string
}

variable "resource_group_name" {
  description = "The resource group that the storage account should be provisioned in"
  type = string
}

variable "storage_location" {
  description = "Location that the storage account should be provisioned"
  type = string
}

variable "account_tier" {
  description = "Define the access tier for the Storage Account (Hot or Cool)"
  type = string
}

variable "account_replication_type" {
  description = "The replication type to use for this Storage Account"
  type = string
}

variable "account_kind" {
  description = "The kind of Storage Account to provision"
  type = string
}