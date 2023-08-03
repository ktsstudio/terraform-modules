resource "yandex_iam_service_account" "sa" {
  name = var.name
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "vault_generic_secret" "keys" {
  path = var.vault-path

  data_json = <<EOT
{
  "bucket": "${var.name}",
  "access_key": "${yandex_iam_service_account_static_access_key.sa-static-key.access_key}",
  "secret_key": "${yandex_iam_service_account_static_access_key.sa-static-key.secret_key}",
  "endpoint_url": "${var.endpoint_url}"
}
EOT
}

resource "yandex_storage_bucket" "bucket" {
  bucket = var.name

  default_storage_class = var.default_storage_class

  grant {
    id          = yandex_iam_service_account.sa.id
    type        = "CanonicalUser"
    permissions = ["READ", "WRITE"]
  }


  dynamic "cors_rule" {
    for_each = var.cors_enabled ? [1] : []

    content {
      allowed_headers = var.cors_allowed_headers
      allowed_methods = var.cors_allowed_methods
      allowed_origins = var.cors_allowed_origins
      expose_headers  = var.cors_expose_headers
      max_age_seconds = var.cors_max_age_seconds
    }
  }
}
