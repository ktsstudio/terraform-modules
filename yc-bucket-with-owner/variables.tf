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
  default = {
    allowed_headers = []
    allowed_methods = []
    allowed_origins = []
    expose_headers  = []
    max_age_seconds = 0
  }
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
