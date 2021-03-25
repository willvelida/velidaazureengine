variable "resource_group_name" {
    default = "velidacosmosserverlessdb-rg"
    description = "Name of the resource group"
    type = string
}

variable "resource_group_location" {
  default = "australiaeast"
  description = "Location of the resource group"
  type = string
}

variable "cosmos_account_name" {
  default = "willvelidaserverlesscosmosdb"
  description = "Name given to the Cosmos DB account"
  type = string
}

variable "external_resource_group_name" {
  default = "velidaazureengine-rg"
  description = "Name of the external resource group"
  type = string
}

variable "cosmos_db_connection_string_secret" {
  default = "serverlesscosmosdbconnectionstring"
  description = "Name of the secret for the Cosmos DB Serverless Connection String"
  type = string
}

variable "cosmos_db_endpoint" {
  default = "serverlesscosmosdbendpoint"
  description = "Name of the secret for the Cosmos DB Serverless Endpoint"
  type = string
}

variable "cosmos_db_primary_key" {
  default = "serverlesscosmosprimarykey"
  description = "Name of the secret for the Cosmos DB Serverless Primary Key"
  type = string
}

variable "cosmos_log_analytics_settings" {
  description = "Name of the diagnostic log settings for Cosmos DB"
  default = "serverless_cosmosdb_loganalytics_diagnostic_settings"
  type = string
}

variable "sql_database_name" {
  description = "Name of the Bookstore Database"
  default = "BookstoreDB"
  type = string
}

variable "sql_container_book" {
  description = "Name of the Book Container"
  default = "Books"
  type = string
}