variable "namespace" {
  type = string
}

variable "schedule" {
  type    = string
  default = "5 4 * * *"
}

variable "image_prefix" {
  type    = string
  default = ""
}

variable "image_prefix_pull_secret" {
  type    = string
  default = ""
}
