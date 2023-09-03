resource "helm_release" "loki" {
  name             = "loki"
  namespace        = "loki"
  create_namespace = true
  chart            = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  version          = "5.14.1"

  values = [file("${path.module}/helm/values/loki.yaml")]
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
