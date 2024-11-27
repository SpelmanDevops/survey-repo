output "predicted_storage_account_name" {
  value = "surveystorage${random_string.suffix.result}"
}

output "predicted_static_web_app_url" {
  value = "https://${azurerm_storage_account.static_web.name}.z6.web.core.windows.net"
}

output "function_app_url" {
  # Dynamically generate the Function App URL
  value = "https://${azurerm_linux_function_app.backend.name}.azurewebsites.net"
}

output "storage_account_primary_key" {
  value = azurerm_storage_account.static_web.primary_access_key
}
