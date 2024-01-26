resource "helm_release" "kyverno" {
  name      = "kyverno"
  namespace = var.namespace

  repository = var.chart_repo
  chart      = var.chart_name
  version    = var.chart_version
  wait       = false

  values = concat([
    templatefile("${path.module}/values/kyverno.yaml", {}),
  ], var.values)
}

resource "helm_release" "kyverno-policy-reporter" {
  depends_on = [
    helm_release.kyverno
  ]

  name      = "kyverno-policy-reporter"
  namespace = helm_release.kyverno.namespace

  repository = var.policy_reporter_chart_repo
  chart      = var.policy_reporter_chart_name
  version    = var.policy_reporter_chart_version
  wait       = false

  values = concat([
    templatefile("${path.module}/values/policy-reporter.yaml", {}),
  ], var.policy_reporter_values)
}
