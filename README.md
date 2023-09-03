# k8s-observability-lab

This repo contains a simple aks cluster in order to test some observability tools. This repo it's only for learning purposes and will not contain production ready tools.

All infrastucture is provisioned with terraform, tho I'm thinking of switch after Hashicorp's news about BSL licensing affecting terraform.

# Pre requisites
- Terraform >= v1.5.5
- Azure CLI >= 2.50

# Backlog

- [x] Prometheus Operator
- [x] Grafana
- [x] Loki
- [ ] Tempo
- [ ] Mimir
- [x] Ingress Controller

# Deploying the Infrastructure

```bash
terraform plan -out out.plan
terraform apply "out.plan"
```
