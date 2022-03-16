resource "random_password" "password" {
  length  = 24
  special = false
}

resource "mongodb_db_user" "user" {
  auth_database = var.name
  name          = var.name
  password      = random_password.password.result
  role {
    role = var.role
    db   = var.name
  }
}

resource "vault_generic_secret" "credentials" {
  path = var.vault_credentials_key

  data_json = <<EOT
{
  "${var.vault_credentials_username_attr}": "${mongodb_db_user.user.name}",
  "${var.vault_credentials_password_attr}": "${random_password.password.result}",
  "${var.vault_credentials_db_attr}": "${var.name}"
}
EOT
}
