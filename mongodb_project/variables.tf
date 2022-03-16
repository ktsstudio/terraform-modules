variable "name" {
  type = string
}

variable "role" {
  type    = string
  default = "readWrite"
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
