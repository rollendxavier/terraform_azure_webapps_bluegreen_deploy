data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "container_rg" {
  name     = "container-${var.environment}-rg"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "container${var.environment}acr"
  resource_group_name = azurerm_resource_group.container_rg.name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false

  identity {
    type = "SystemAssigned"
  }

  #   georeplications {
  #     location                = "Australia Central"
  #     zone_redundancy_enabled = true
  #     tags                    = {}
  #   }
  #   georeplications {
  #     location                = "Australia Central 2"
  #     zone_redundancy_enabled = true
  #     tags                    = {}
  #   }
}