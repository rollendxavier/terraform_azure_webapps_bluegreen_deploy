terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
}

module "container" {
  source      = "./module/container"
  environment = "test"
}

module "app" {
  source      = "./module/app"
  app_name    = "blue-green-app"
  environment = "test"
  acr_name    = module.container.name
  acr_id      = module.container.id
}