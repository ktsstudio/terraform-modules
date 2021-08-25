resource "sentry_team" "team" {
  for_each     = var.teams
  organization = var.organization
  name         = each.key
  slug         = each.key
}
