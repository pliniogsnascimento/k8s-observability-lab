resource "helm_release" "prometheus-operator" {
  name             = "prometheus-operator"
  namespace        = "prometheus"
  create_namespace = true
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "47.1.0"

  values     = [file("${path.module}/helm/values/prometheus.yaml")]
  depends_on = [helm_release.nginx-ingress-controller]
}
