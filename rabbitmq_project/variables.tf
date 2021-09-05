variable "name" {
  type = string
}

variable "permissions_configure" {
  type    = string
  default = ".*"
}

variable "permissions_write" {
  type    = string
  default = ".*"
}

variable "permissions_read" {
  type    = string
  default = ".*"
}

variable "ha_mode" {
  type    = string
  default = "all"
}

variable "vault_credentials_key" {
  type = string
}

variable "vault_credentials_username_attr" {
  type    = string
  default = "rabbitmq_username"
}

variable "vault_credentials_password_attr" {
  type    = string
  default = "rabbitmq_password"
}
