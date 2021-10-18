variable "projects" {
  type = map(object({
    team        = string
    platform    = optional(string)
    resolve_age = optional(number)
  }))

  default = {}
}

variable "organization" {
  type = string
}
