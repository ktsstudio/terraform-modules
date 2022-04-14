resource "kubernetes_daemonset" "sysctl-tuner" {
  metadata {
    name      = "sysctl-tuner"
    namespace = var.namespace
  }

  spec {
    strategy {
      type = "RollingUpdate"
    }
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "sysctl-tuner"
      }
    }
    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "sysctl-tuner"
        }
      }
      spec {
        toleration {
          key      = "node-role.kubernetes.io/master"
          operator = "Exists"
          effect   = "NoSchedule"
        }

        toleration {
          key      = "node-role.kubernetes.io/control-plane"
          operator = "Exists"
          effect   = "NoSchedule"
        }

        toleration {
          operator = "Exists"
          effect   = "NoSchedule"
        }

        container {
          name              = "sysctl-tuner"
          image             = "busybox"
          image_pull_policy = "Always"
          command = [
            "sh",
            "-c",
            <<EOT
            while true; do
                %{~for k, v in var.params}
                sysctl -w ${k}=${v}
                %{~endfor}
                # More options are in http://www.brendangregg.com/blog/2017-12-31/reinvent-netflix-ec2-tuning.html
                sleep ${var.sleep_seconds} ;
            done
            EOT
          ]

          security_context {
            privileged = true
          }
        }

        host_network = true
        host_pid     = true
        host_ipc     = true
      }
    }
  }
}
