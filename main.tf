resource "azurerm_storage_account" "backend" {
  name                     = local.sa_name
  resource_group_name      = data.azurerm_resource_group.backend.name
  location                 = data.azurerm_resource_group.backend.location
  account_tier             = var.backend_storage_account_tier
  account_replication_type = var.backend_storage_account_replication_type
  tags                     = var.backend_resource_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "backend" {
  name                  = local.sc_name
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }
}
