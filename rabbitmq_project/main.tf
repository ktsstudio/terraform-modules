resource "rabbitmq_vhost" "vhost" {
  name = var.name
}

resource "random_password" "password" {
  length  = 24
  special = false
}

resource "rabbitmq_user" "user" {
  name     = var.name
  password = random_password.password.result
}

resource "vault_generic_secret" "credentials" {
  path = var.vault_credentials_key

  data_json = <<EOT
{
  "${var.vault_credentials_username_attr}": "${rabbitmq_user.user.name}",
  "${var.vault_credentials_password_attr}": "${random_password.password.result}"
}
EOT
}

resource "rabbitmq_permissions" "user_vhost_permissions" {
  user  = rabbitmq_user.user.name
  vhost = rabbitmq_vhost.vhost.name

  permissions {
    configure = var.permissions_configure
    write     = var.permissions_write
    read      = var.permissions_read
  }
}

resource "rabbitmq_policy" "ha" {
  name  = "${var.name}-ha"
  vhost = rabbitmq_vhost.vhost.name

  policy {
    pattern  = ".*"
    priority = 0
    apply_to = "all"

    definition = {
      ha-mode = var.ha_mode
    }
  }
}
