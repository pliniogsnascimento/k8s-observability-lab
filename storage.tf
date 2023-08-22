resource "azurerm_storage_account" "loki" {
  name                     = "lokistoracc"
  resource_group_name      = azurerm_resource_group.cluster_rg.name
  location                 = azurerm_resource_group.cluster_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "loki" {
  name                  = "loki-storage"
  storage_account_name  = azurerm_storage_account.loki.name
  container_access_type = "private"
}
