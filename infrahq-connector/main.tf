resource "helm_release" "infra-connector" {
  name      = var.name
  namespace = var.namespace

  repository = var.chart_repo
  chart      = var.chart_name
  version    = var.chart_version
  wait       = true

  set = [
    {
      name  = "replicas"
      value = tostring(var.replicas)
    },
    {
      name  = "config.server.url"
      value = var.infra_server
    },
    {
      name  = "config.name"
      value = var.infra_connector_name
    }
  ]

  set_sensitive = [
    {
      name  = "config.accessKey"
      value = var.infra_access_key
    }
  ]

  values = concat([
    templatefile("${path.module}/values.yaml", {}),
  ], var.values)
}
