resource "selectel_dbaas_user_v1" "db_user" {
  count        = length(var.databases)
  project_id   = var.project_id
  region       = var.region
  datastore_id = var.datastore_id
  name         = var.databases[count.index].user
  password     = var.databases[count.index].password
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
