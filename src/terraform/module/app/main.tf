resource "azurerm_resource_group" "application_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_application_insights" "application_insights" {
  name                = var.appinsights
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "Web"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Api App Service
resource "azurerm_app_service" "api_app" {
  name                = var.api_app_name
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    always_on                = false
    dotnet_framework_version = "v4.0"
    websockets_enabled       = true
    managed_pipeline_mode    = "Integrated"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"            = azurerm_application_insights.application_insights.instrumentation_key
    "ApplicationInsights:InstrumentationKey"    = azurerm_application_insights.application_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"     = azurerm_application_insights.application_insights.connection_string
    "ApplicationInsights:ConnectionString"      = azurerm_application_insights.application_insights.connection_string
  }
}

resource "azurerm_app_service_slot" "api_slot" {
  name                = "blue"
  app_service_name    = azurerm_app_service.api_app.name
  location            = azurerm_resource_group.zerorg.location
  resource_group_name = azurerm_resource_group.zerorg.name
  app_service_plan_id = azurerm_app_service_plan.zerosp.id

  site_config {
    always_on                = false
    dotnet_framework_version = "v4.0"
    websockets_enabled       = true
    managed_pipeline_mode    = "Integrated"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.heroesappinsights.instrumentation_key
    "ApplicationInsights:InstrumentationKey" = azurerm_application_insights.heroesappinsights.instrumentation_key
  }
}