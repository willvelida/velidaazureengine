output "connection_string" {
  description = "The Connection String for the Storage Account"
  value = azurerm_storage_account.this.primary_connection_string
}

output "primary_access_key" {
  description = "The Primary Access Key for the Storage Account"
  value = azurerm_storage_account.this.primary_access_key
}