resource "yandex_storage_bucket" "bucket" {
  bucket                = var.name
  default_storage_class = var.default_storage_class
  tags                  = var.tags
  acl                   = var.acl

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
