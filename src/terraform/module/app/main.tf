resource "azurerm_resource_group" "application_rg" {
  name     = "${var.app_name}-${var.environment}-rg"
  location = var.location
}

resource "azurerm_application_insights" "application_insights" {
  name                = "${var.app_name}-${var.environment}-ai"
  location            = var.location
  resource_group_name = azurerm_resource_group.application_rg.name
  application_type    = "web"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "${var.app_name}-${var.environment}-asp"
  location            = var.location
  resource_group_name = azurerm_resource_group.application_rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier     = "PremiumV2"
    size     = "P2v2"
    capacity = "3"
  }
}

locals {
  site_config = {
    always_on                            = false
    dotnet_framework_version             = "v4.0"
    websockets_enabled                   = true
    managed_pipeline_mode                = "Integrated"
    scm_type                             = "VSTSRM"
    linux_fx_version                     = "DOCKER|${var.acr_name}/Container-App:latest" #define the container image url
    health_check_path                    = "/health"
    acr_use_managed_identity_credentials = true
  }
}

locals {
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.application_insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.application_insights.connection_string
    "DOCKER_REGISTRY_SERVER_URL"            = "https://${var.acr_name}.azurecr.io"
  }
}

# Api App Service
resource "azurerm_app_service" "web_app" {
  name                    = "${var.app_name}-${var.environment}-app"
  location                = var.location
  resource_group_name     = azurerm_resource_group.application_rg.name
  app_service_plan_id     = azurerm_app_service_plan.app_service_plan.id
  https_only              = true
  client_affinity_enabled = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                            = false
    dotnet_framework_version             = "v4.0"
    websockets_enabled                   = true
    managed_pipeline_mode                = "Integrated"
    scm_type                             = "VSTSRM"
    linux_fx_version                     = "DOCKER|${var.acr_name}/Container-App:latest" #define the container image url
    health_check_path                    = "/health"
    acr_use_managed_identity_credentials = true
  }
  app_settings = local.app_settings
}

resource "azurerm_app_service_slot" "web_app_slot" {
  name                = "blue"
  app_service_name    = azurerm_app_service.web_app.name
  location            = azurerm_resource_group.application_rg.location
  resource_group_name = azurerm_resource_group.application_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    always_on                            = false
    dotnet_framework_version             = "v4.0"
    websockets_enabled                   = true
    managed_pipeline_mode                = "Integrated"
    scm_type                             = "VSTSRM"
    linux_fx_version                     = "DOCKER|${var.acr_name}/Container-App:latest" #define the container image url
    health_check_path                    = "/health"
    acr_use_managed_identity_credentials = true
  }

  app_settings = local.app_settings
}

resource "azurerm_role_assignment" "app_role" {
  principal_id                     = azurerm_app_service.web_app.identity[0].principal_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}