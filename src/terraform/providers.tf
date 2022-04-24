terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # Whilst version is optional, it is strongly recommend using it to lock the version of the provider being used.
      version = ">=2.94.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.16.0"
    }
  }
}