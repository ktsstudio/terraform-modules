resource "kubernetes_service_account" "sa" {
  metadata {
    name      = var.sa_name
    namespace = var.namespace
  }
  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "cr" {
  metadata {
    name = var.cluster_role_name
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    non_resource_urls = ["*"]
    verbs             = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "crb" {
  metadata {
    name = var.cluster_role_binding_name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.cr.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.sa.metadata[0].name
    namespace = kubernetes_service_account.sa.metadata[0].namespace
  }
}

resource "kubernetes_config_map" "configmap" {
  metadata {
    name      = "addon-operator"
    namespace = kubernetes_service_account.sa.metadata[0].namespace
  }

  data = {
    global             = ""
    sysctlTunerEnabled = "true"
    sysctlTuner        = <<EOT
      params:
        fs.inotify.max_user_instances: "8192"
        fs.inotify.max_user_watches: "524288"
      sleep: "300"
    EOT
  }
}

resource "kubernetes_pod" "operator" {
  metadata {
    name      = "sysctl-tuner-operator"
    namespace = kubernetes_config_map.configmap.metadata[0].namespace
  }

  spec {
    container {
      name              = "sysctl-tuner-operator"
      image             = var.image
      image_pull_policy = "Always"

      args = ["--namespace", kubernetes_config_map.configmap.metadata[0].namespace]

      env {
        name  = "RLOG_LOG_LEVEL"
        value = "DEBUG"
      }
    }
    service_account_name = kubernetes_service_account.sa.metadata[0].name
  }
}
