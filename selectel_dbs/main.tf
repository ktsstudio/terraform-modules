data "vault_generic_secret" "db_creds" {
  for_each = var.databases
  path     = "${var.vault_db_creds_key}/${each.key}"
}

resource "selectel_dbaas_user_v1" "db_user" {
  for_each     = var.databases
  project_id   = var.project_id
  region       = var.region
  datastore_id = var.datastore_id
  name         = data.vault_generic_secret.db_creds[each.key].data["user"]
  password     = data.vault_generic_secret.db_creds[each.key].data["password"]
}

resource "selectel_dbaas_database_v1" "database_1" {
  for_each     = var.databases
  project_id   = var.project_id
  region       = var.region
  datastore_id = var.datastore_id
  owner_id     = selectel_dbaas_user_v1.db_user[each.key].id
  name         = each.key
  lc_ctype     = each.value.lc_ctype
  lc_collate   = each.value.lc_collate
}
