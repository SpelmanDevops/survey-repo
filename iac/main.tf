provider "azurerm" {
    features {}  
}

# Resource Group 
resource "azurerm_resource_group" "main" {
    name = "survey-rg"
    location = "UKSouth"
}

# Storage Account for Static Web App 
resource "azurerm_storage_account" "static_web" {
    name                     = "surveystatic${random_string.suffix.result}"
    resource_group_name      = azurerm_resource_group.main.name
    location                 = azurerm_resource_group.main.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    static_website {
      index_document = "index.html"
      error_404_document = "404.html"
    }  
}

resource "random_string" "suffix" {
    length  = 6
    upper   = false
    special = false  
}

# Service Plan for Azure Functions
resource "azurerm_service_plan" "app" {
  name                = "survey-service-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name = "S1"
}

# Function App for Backend
resource "azurerm_function_app" "backend" {
  name                       = "survey-backend${random_string.suffix.result}"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  storage_account_name       = azurerm_storage_account.static_web.name
  storage_account_access_key = azurerm_storage_account.static_web.primary_access_key
  app_service_plan_id        = azurerm_service_plan.app.id
  version                    = "~3"
}