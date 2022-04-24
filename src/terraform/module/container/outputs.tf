output "id" {
  description = "The Container Registry ID"
  value       = azurerm_container_registry.acr.id
}

output "name" {
  description = "The Container Registry Name"
  value       = azurerm_container_registry.acr.name
}

output "login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.acr.login_server
}
