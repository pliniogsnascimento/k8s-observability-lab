resource "helm_release" "prometheus-operator" {
  # count            = 0
  name             = "prometheus-operator"
  namespace        = "prometheus"
  create_namespace = true
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "47.1.0"

  values = [file("${path.module}/values/prometheus-values.yaml")]
}
