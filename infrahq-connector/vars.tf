variable "namespace" {
  type = string
}

variable "name" {
  type    = string
  default = "infra-connector"
}

variable "chart_repo" {
  type    = string
  default = "https://helm.infrahq.com"
}

variable "chart_name" {
  type    = string
  default = "infra"
}

variable "chart_version" {
  type = string
}

variable "values" {
  type    = string
  default = ""
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
