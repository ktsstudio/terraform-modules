variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "datastore_id" {
  type = string
}

variable "name" {
  type = string
}

variable "lc_ctype" {
  type    = string
  default = "ru_RU.utf8"
}

variable "lc_collate" {
  type    = string
  default = "ru_RU.utf8"
}

variable "vault_credentials_key" {
  type = string
}

variable "vault_credentials_username_attr" {
  type    = string
  default = "username"
}

variable "vault_credentials_password_attr" {
  type    = string
  default = "password"
}

variable "vault_credentials_db_attr" {
  type    = string
  default = "db"
}
