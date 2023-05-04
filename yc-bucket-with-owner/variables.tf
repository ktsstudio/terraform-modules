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
