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

data "azuread_client_config" "current" {}

resource "azuread_application" "main" {
  display_name     = "lokistorage"
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "main" {
  application_id = azuread_application.main.application_id
  owners         = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.object_id
}

resource "azurerm_role_assignment" "loki" {
  scope                = azurerm_storage_account.loki.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_service_principal.main.id
}

output "principal_password" {
  value     = azuread_service_principal_password.main.value
  sensitive = true
}

output "tenant_id" {
  value     = azurerm_storage_account.loki.identity.0.tenant_id
  sensitive = true
}

output "sp_id" {
  value     = azurerm_storage_account.loki.identity.0.principal_id
  sensitive = true
}

