variable "namespace" {
  type = string
}

variable "sleep_seconds" {
  type    = number
  default = 300
}

variable "params" {
  type = map(string)
}
