variable "namespaces" {
  type = list(string)
}

variable "groups_cr_mapping" {
  type = map(object({
    group        = string
    cluster_role = string
  }))
}
