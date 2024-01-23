resource "random_password" "password" {
  length  = 24
  special = false
}

resource "selectel_dbaas_user_v1" "user" {
  project_id   = var.project_id
  region       = var.region
  datastore_id = var.datastore_id
  name         = var.name
  password     = random_password.password.result
}

resource "vault_generic_secret" "credentials" {
  path                = var.vault_credentials_key
  delete_all_versions = true

  data_json = <<EOT
{
  "${var.vault_credentials_username_attr}": "${var.name}",
  "${var.vault_credentials_password_attr}": "${random_password.password.result}",
  "${var.vault_credentials_db_attr}": "${var.name}"
}
EOT
}

resource "selectel_dbaas_database_v1" "db" {
  project_id   = var.project_id
  region       = var.region
  datastore_id = var.datastore_id
  owner_id     = selectel_dbaas_user_v1.user.id
  name         = var.name
  lc_ctype     = var.lc_ctype
  lc_collate   = var.lc_collate
}
