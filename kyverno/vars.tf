variable "namespace" {
  type = string
}

variable "chart_repo" {
  type    = string
  default = "https://kyverno.github.io/kyverno/"
}

variable "chart_name" {
  type    = string
  default = "kyverno"
}

variable "chart_version" {
  type = string
}

variable "values" {
  type    = list(string)
  default = []
}


variable "policy_reporter_chart_repo" {
  type    = string
  default = "https://kyverno.github.io/policy-reporter"
}

variable "policy_reporter_chart_name" {
  type    = string
  default = "policy-reporter"
}

variable "policy_reporter_chart_version" {
  type    = string
  default = "2.22.0"
}

variable "policy_reporter_values" {
  type    = list(string)
  default = []
}
