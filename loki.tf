resource "helm_release" "loki" {
  name             = "loki"
  namespace        = "loki"
  create_namespace = true
  chart            = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  version          = "5.20.0"
  timeout          = "599"

  values = [file("${path.module}/helm/values/loki.yaml")]

  set {
    name  = "loki.storage_config.azure.account_name"
    value = azurerm_storage_account.loki.name
  }

  set {
    name  = "loki.storage_config.azure.tenant_id"
    value = azurerm_storage_account.loki.identity.0.tenant_id
  }

  set {
    name  = "loki.storage_config.azure.client_id"
    value = azuread_application.main.application_id
  }

  set {
    name  = "loki.storage_config.azure.client_secret"
    value = azuread_service_principal_password.main.value
  }

  set {
    name  = "loki.storage_config.azure.container_name"
    value = azurerm_storage_container.loki.name
  }
}

resource "helm_release" "promtail" {
  name             = "promtail"
  namespace        = "promtail"
  create_namespace = true
  chart            = "promtail"
  repository       = "https://grafana.github.io/helm-charts"
  version          = "6.14.1"

  values = [file("${path.module}/helm/values/promtail.yaml")]
}
