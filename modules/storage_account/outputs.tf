output "connection_string" {
  description = "The Connection String for the Storage Account"
  value = azurerm_storage_account.this.primary_connection_string
}

output "primary_access_key" {
  description = "The Primary Access Key for the Storage Account"
  value = azurerm_storage_account.this.primary_access_key
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value = azurerm_storage_account.this.name
}

output "storage_account_id" {
  description = "The ID for the Storage Account"
  value = azurerm_storage_account.this.id
}