provider "azurerm" {
  features {}
  subscription_id = "24e88ed7-ceab-4e5c-b300-2138aba237fb"
}

resource "azurerm_resource_group" "main" {
  name     = "survey-rg"
  location = "East US"
}

resource "azurerm_storage_account" "static_web" {
  name                     = "surveystorage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account_static_website" "static_web" {
  storage_account_id = azurerm_storage_account.static_web.id
  index_document     = "index.html"
  error_404_document = "404.html"
}

resource "azurerm_service_plan" "app" {
  name                = "survey-service-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_function_app" "backend" {
  name                       = "survey-backend${random_string.suffix.result}"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  storage_account_name       = azurerm_storage_account.static_web.name
  storage_account_access_key = azurerm_storage_account.static_web.primary_access_key
  service_plan_id            = azurerm_service_plan.app.id

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}
