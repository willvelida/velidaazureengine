variable "resource_group_name" {
  default = "velidasynapse-rg"
  description = "Name of the resource group"
  type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "Location of the resource group"
  type = string
}

variable "storage_account_name" {
  default = "velidasynapsedatalake"
  description = "Name of the Storage Account used for Synapse"
  type = string
}

variable "file_system_name" {
  default = "velidafilesystem"
  description = "Name of the Data Lake Gen2 Filesystem"
  type = string
}

variable "synapse_workspace_name" {
  default = "velidasynapseworkspace"
  description = "Name of the Synapse Workspace"
  type = string
}