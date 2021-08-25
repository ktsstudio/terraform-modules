output "prod_rw" {
  value = tomap({
    for k, _ in var.teams : k => vault_policy.apps_prod_rw[k].name
  })
}

output "prod_ro" {
  value = tomap({
    for k, _ in var.teams : k => vault_policy.apps_prod_ro[k].name
  })
}

output "dev_rw" {
  value = tomap({
    for k, _ in var.teams : k => vault_policy.apps_dev_rw[k].name
  })
}

output "dev_ro" {
  value = tomap({
    for k, _ in var.teams : k => vault_policy.apps_dev_ro[k].name
  })
}
