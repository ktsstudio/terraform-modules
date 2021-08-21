variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "datastore_id" {
  type = string
}

variable "databases" {
  type = map(object({
    lc_ctype   = string
    lc_collate = string
  }))

  default = {}
}

variable "vault_db_creds_key" {
  type = string
}
