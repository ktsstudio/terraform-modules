resource "vault_policy" "apps_dev_rw" {
  for_each = var.teams
  name     = "apps_${each.key}_dev_rw"

  policy = <<EOT
    path "${var.apps_dev_prefix}/${each.key}/*"
    {
      capabilities = ["read", "create", "update", "list", "delete", "sudo"]
    }
  EOT
}

resource "vault_policy" "apps_dev_ro" {
  for_each = var.teams
  name     = "apps_${each.key}_dev_ro"

  policy = <<EOT
    path "${var.apps_dev_prefix}/${each.key}/*"
    {
      capabilities = ["read", "list"]
    }
  EOT
}

resource "vault_policy" "apps_stage_rw" {
  for_each = var.teams
  name     = "apps_${each.key}_stage_rw"

  policy = <<EOT
    path "${var.apps_stage_prefix}/${each.key}/*"
    {
      capabilities = ["read", "create", "update", "list", "delete", "sudo"]
    }
  EOT
}

resource "vault_policy" "apps_stage_ro" {
  for_each = var.teams
  name     = "apps_${each.key}_stage_ro"

  policy = <<EOT
    path "${var.apps_stage_prefix}/${each.key}/*"
    {
      capabilities = ["read", "list"]
    }
  EOT
}

resource "vault_policy" "apps_prod_rw" {
  for_each = var.teams
  name     = "apps_${each.key}_prod_rw"

  policy = <<EOT
    path "${var.apps_prod_prefix}/${each.key}/*"
    {
      capabilities = ["read", "create", "update", "list", "delete", "sudo"]
    }
  EOT
}

resource "vault_policy" "apps_prod_ro" {
  for_each = var.teams
  name     = "apps_${each.key}_prod_ro"

  policy = <<EOT
    path "${var.apps_prod_prefix}/${each.key}/*"
    {
      capabilities = ["read", "list"]
    }
  EOT
}
