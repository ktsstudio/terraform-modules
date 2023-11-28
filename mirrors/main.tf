resource "helm_release" "mirrors" {
  name      = var.name
  namespace = var.namespace

  repository = var.chart_repo
  chart      = var.chart_name
  version    = var.chart_version
  wait       = true

  values = concat([
    templatefile("${path.module}/values.yaml", {}),
  ], var.values)
}
