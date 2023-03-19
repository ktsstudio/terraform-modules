variable "namespace" {
  type = string
}

variable "schedule" {
  type    = string
  default = "5 4 * * *"
}
