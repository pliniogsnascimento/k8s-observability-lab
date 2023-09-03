resource "helm_release" "apps" {
  name             = "apps"
  namespace        = "default"
  create_namespace = false
  chart            = "apps"
  repository       = "helm/charts"

  depends_on = [helm_release.prometheus-operator]
}
