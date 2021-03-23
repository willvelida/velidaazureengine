variable "file_system_name" {
  description = "The name of the Data Lake Gen2 File System which should be created within the Storage Account"
  type = string
}

variable "storage_account_id" {
  description = "Specifies the ID of the Sotrage Account in which the Data Lake Gen2 System should exist"
  type = string
}