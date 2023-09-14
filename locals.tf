locals {
  default_nodepool_agents_count      = 5
  microservice_nodepool_agents_count = 0
  max_pods                           = 0
  agents_size                        = "Standard_D2s_v3"
  resource_group_name                = "observability"
  location                           = "Central US"
  prefix                             = "observability"
  kubernetes_version                 = "1.27.3"
}
