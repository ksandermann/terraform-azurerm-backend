output "backend_resource_group_name" {
  value = azurerm_storage_account.backend.resource_group_name
}

output "backend_storage_account_name" {
  value = azurerm_storage_account.backend.name
}

output "backend_storage_container_name" {
  value = azurerm_storage_container.backend.name
}

