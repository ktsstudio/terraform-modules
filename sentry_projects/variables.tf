variable "projects" {
  type = map(object({
    platform    = optional(string)
    resolve_age = optional(number)
  }))

  default = {}
}

variable "organization" {
  type = string
}

variable "team" {
  type = string
}
