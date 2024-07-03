resource "yandex_iam_service_account" "sa" {
  name = var.name
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "vault_generic_secret" "keys" {
  path                = var.vault-path
  delete_all_versions = true

  data_json = <<EOT
{
  "${var.vault_key_bucket}": "${var.name}",
  "${var.vault_key_access_key}": "${yandex_iam_service_account_static_access_key.sa-static-key.access_key}",
  "${var.vault_key_secret_key}": "${yandex_iam_service_account_static_access_key.sa-static-key.secret_key}",
  "${var.vault_key_endpoint_url}": "${var.endpoint_url}",
  "${var.vault_key_region}": "${var.region}"
}
EOT
}

resource "yandex_storage_bucket" "bucket" {
  bucket                = var.name
  default_storage_class = var.default_storage_class
  tags                  = var.tags

  grant {
    id          = yandex_iam_service_account.sa.id
    type        = "CanonicalUser"
    permissions = ["READ", "WRITE"]
  }


  dynamic "cors_rule" {
    for_each = var.cors_rules

    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }
}
