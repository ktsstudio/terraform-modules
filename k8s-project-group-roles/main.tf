locals {
  _bindings = flatten([
    for ns in var.namespaces : [
      for name, ob in var.groups_cr_mapping : {
        namespace    = ns
        name         = name
        group        = ob.group
        cluster_role = ob.cluster_role
      }
    ]
  ])
  role_bindings_map = {
    for b in local._bindings : "${b.namespace}:${b.group}:${b.cluster_role}" => b
  }
}


resource "kubernetes_role_binding" "rb" {
  for_each = local.role_bindings_map
  metadata {
    name      = format("kts-rb-group-%s", each.value.name)
    namespace = each.value.namespace
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = each.value.group
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = each.value.cluster_role
  }
}
