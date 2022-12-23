resource "helm_release" "infra-connector" {
  name      = var.name
  namespace = var.namespace

  repository = var.chart_repo
  chart      = var.chart_name
  version    = var.chart_version
  wait       = true

  set {
    name  = "replicas"
    value = var.replicas
  }

  set {
    name  = "config.server.url"
    value = var.infra_server
  }

  set_sensitive {
    name  = "config.accessKey"
    value = var.infra_access_key
  }

  set {
    name  = "config.name"
    value = var.infra_connector_name
  }

  values = [
    templatefile("${path.module}/values.yaml", {}),
    var.values
  ]
}
