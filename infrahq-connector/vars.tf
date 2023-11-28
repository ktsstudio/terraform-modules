variable "namespace" {
  type = string
}

variable "name" {
  type    = string
  default = "infra-connector"
}

variable "chart_repo" {
  type    = string
  default = "https://infrahq.github.io/helm-charts"
}

variable "chart_name" {
  type    = string
  default = "infra"
}

variable "chart_version" {
  type = string
}

variable "values" {
  type    = list(string)
  default = []
}

variable "infra_server" {
  type = string
}

variable "infra_access_key" {
  type      = string
  sensitive = true
}

variable "infra_connector_name" {
  type = string
}

variable "replicas" {
  type    = number
  default = 2
}
