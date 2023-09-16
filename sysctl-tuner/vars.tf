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

variable "image_prefix" {
  type    = string
  default = ""
}

variable "image_prefix_pull_secret" {
  type    = string
  default = ""
}
