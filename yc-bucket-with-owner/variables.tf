variable "name" {
  type = string
}

variable "vault-path" {
  type = string
}

variable "default_storage_class" {
  type    = string
  default = "STANDARD"
}

variable "endpoint_url" {
  type    = string
  default = "https://storage.yandexcloud.net"
}

variable "region" {
  type    = string
  default = "ru-central1"
}

variable "cors_rules" {
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  }))
  default = []
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Bucket tags"
}

variable "vault_key_bucket" {
  type    = string
  default = "bucket"
}

variable "vault_key_endpoint_url" {
  type    = string
  default = "endpoint_url"
}

variable "vault_key_access_key" {
  type    = string
  default = "access_key"
}

variable "vault_key_secret_key" {
  type    = string
  default = "secret_key"
}

variable "vault_key_region" {
  type    = string
  default = "region"
}

variable "public_access" {
  type    = bool
  default = false
}


variable "delete_incomplete_multipart_upload_days_enabled" {
  type    = bool
  default = false
}

variable "delete_incomplete_multipart_upload_days" {
  type    = number
  default = 7
}

variable "enable_expiration_rule" {
  description = "Включить правило удаления объектов через expiration"
  type        = bool
  default     = false
}

variable "expiration_days" {
  description = "Сколько дней до удаления объектов"
  type        = number
  default     = 90
}
