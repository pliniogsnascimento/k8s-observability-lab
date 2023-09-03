# Docs https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli#create-an-ingress-controller
resource "helm_release" "nginx-ingress-controller" {
  name             = "ingress-nginx"
  namespace        = "nginx-controller"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"

  set {
    name  = "controller.replicaCount"
    value = 2
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }
}
