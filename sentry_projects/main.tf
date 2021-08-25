resource "sentry_project" "project" {
  for_each     = var.projects
  organization = var.organization
  team         = var.team
  name         = each.key
  slug         = each.key
  platform     = each.value.platform
  resolve_age  = each.value.resolve_age
}
