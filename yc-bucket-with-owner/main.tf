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
  "secret_key": "${yandex_iam_service_account_static_access_key.sa-static-key.secret_key}"
}
EOT
}

resource "yandex_storage_bucket" "bucket" {
  bucket = var.name

  grant {
    id          = yandex_iam_service_account.sa.id
    type        = "CanonicalUser"
    permissions = ["READ", "WRITE"]
  }
}
