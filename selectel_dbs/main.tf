data "vault_generic_secret" "db_creds" {
  count = length(var.databases)
  path  = "${var.vault_db_creds_key}/${var.databases[count.index].name}"
}

resource "selectel_dbaas_user_v1" "db_user" {
  count        = length(var.databases)
  project_id   = var.project_id
  region       = var.region
  datastore_id = var.datastore_id
  name         = data.vault_generic_secret.db_creds[count.index].data["user"]
  password     = data.vault_generic_secret.db_creds[count.index].data["password"]
}

resource "selectel_dbaas_database_v1" "database_1" {
  count        = length(var.databases)
  project_id   = var.project_id
  region       = var.region
  datastore_id = var.datastore_id
  owner_id     = selectel_dbaas_user_v1.db_user[count.index].id
  name         = var.databases[count.index].name
  lc_ctype     = var.databases[count.index].lc_ctype
  lc_collate   = var.databases[count.index].lc_collate
}
