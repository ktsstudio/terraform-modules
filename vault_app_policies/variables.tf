variable "teams" {
  type = map(object({

  }))

  default = {}
}

variable "apps_dev_prefix" {
  type = string
}

variable "apps_prod_prefix" {
  type = string
}
