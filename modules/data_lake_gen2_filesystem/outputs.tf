output "filesystem_id" {
    description = "The ID of the Data Lake Gen2 FileSystem"
    value = azurerm_storage_data_lake_gen2_filesystem.this.id
}