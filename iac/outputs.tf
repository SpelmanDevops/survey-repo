output "static_web_app_url" {
    value = azurerm_storage_account.static_web.primary_web_endpoint
}

output "function_app_url" {
    value = azurerm_function_app.backend.default_hostname
}