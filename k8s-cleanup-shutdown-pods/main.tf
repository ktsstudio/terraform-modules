locals {
  common_name = "kts-cleanup-shutdown-pods"
}

resource "kubernetes_cluster_role_v1" "cleanup-shutdown-pods" {
  metadata {
    name = local.common_name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["delete", "list"]
  }
}

resource "kubernetes_service_account_v1" "cleanup-shutdown-pods" {
  metadata {
    name      = local.common_name
    namespace = var.namespace
  }
}

resource "kubernetes_cluster_role_binding_v1" "cleanup-shutdown-pods" {
  metadata {
    name = local.common_name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.cleanup-shutdown-pods.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.cleanup-shutdown-pods.metadata[0].name
    namespace = kubernetes_service_account_v1.cleanup-shutdown-pods.metadata[0].namespace
  }
}

resource "kubernetes_cron_job_v1" "cleanup-shutdown-pods" {
  depends_on = [
    kubernetes_cluster_role_binding_v1.cleanup-shutdown-pods
  ]

  metadata {
    name      = local.common_name
    namespace = var.namespace
    labels = {
      "app.kubernetes.io/name" = local.common_name
    }
  }
  spec {
    concurrency_policy            = "Forbid"
    failed_jobs_history_limit     = 5
    schedule                      = var.schedule
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = local.common_name
        }
      }
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {
            labels = {
              "app.kubernetes.io/name" = local.common_name
            }
          }
          spec {

            dynamic "image_pull_secrets" {
              for_each = var.image_prefix_pull_secret != "" ? toset([var.image_prefix_pull_secret]) : toset([])
              content {
                name = var.image_prefix_pull_secret
              }
            }

            service_account_name = kubernetes_service_account_v1.cleanup-shutdown-pods.metadata[0].name
            container {
              name    = local.common_name
              image   = "${var.image_prefix}alpine/kubectl"
              command = ["/bin/sh"]
              args    = ["-c", "kubectl get po --all-namespaces | grep -E 'Shutdown|Evicted|Terminate|ContainerStatusUnknown|Error|Completed' | awk '{print \"kubectl -n \"$1\" delete po \"$2\" --ignore-not-found=true\"}' | xargs -P8 -I{} sh -c '{}'"]
            }
          }
        }
      }
    }
  }
}
