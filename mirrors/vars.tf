variable "namespace" {
  type = string
}

variable "name" {
  type    = string
  default = "mirrors"
}

variable "chart_repo" {
  type    = string
  default = "https://ktsstudio.github.io/helm-charts"
}

variable "chart_name" {
  type    = string
  default = "mirrors"
}

variable "chart_version" {
  type = string
}

variable "values" {
  type    = string
  default = "values.yaml"
}
