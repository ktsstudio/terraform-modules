resource "kubernetes_service_account" "service_account" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
  automount_service_account_token = false
}

resource "kubernetes_cluster_role_binding" "crb" {
  metadata {
    name = var.name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.cluster_role
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.service_account.metadata[0].name
    namespace = kubernetes_service_account.service_account.metadata[0].namespace
  }
}
