variable "zone" {
  type = string
}

variable "A" {
  type = map(object({
    name    = string
    ttl     = number
    value   = string
    proxied = bool
  }))

  default = {}
}

variable "AAAA" {
  type = map(object({
    name    = string
    ttl     = number
    value   = string
    proxied = bool
  }))

  default = {}
}

variable "CNAME" {
  type = map(object({
    name    = string
    ttl     = number
    value   = string
    proxied = bool
  }))

  default = {}
}

variable "TXT" {
  type = map(object({
    name  = string
    ttl   = number
    value = string
  }))

  default = {}
}

variable "MX" {
  type = map(object({
    name     = string
    ttl      = number
    value    = string
    priority = number
  }))

  default = {}
}

variable "NS" {
  type = map(object({
    name  = string
    ttl   = number
    value = string
  }))

  default = {}
}
