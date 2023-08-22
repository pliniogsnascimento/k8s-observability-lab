data "azuread_client_config" "current" {}

resource "azuread_application" "main" {
  display_name = "lokistorage"
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

# resource "azurerm_role_definition" "loki_blob_role" {
#   role_definition_id = "00000000-0000-0000-0000-000000000000"
#   name               = "my-custom-role-definition"
#   scope              = azurerm_storage_container.loki.id

#   permissions {
#     actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
#     not_actions = []
#   }

#   assignable_scopes = [
#     data.azurerm_subscription.primary.id,
#   ]
# }

output "principal_key" {
  value = azuread_service_principal_password.main.key_id
}

output "principal_password" {
  value     = azuread_service_principal_password.main.value
  sensitive = true
}
