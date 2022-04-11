variable "sa_name" {
  type    = string
  default = "sysctl-tuner-account"
}

variable "cluster_role_name" {
  type    = string
  default = "sysctl-tuner-account"
}

variable "cluster_role_binding_name" {
  type    = string
  default = "sysctl-tuner-role-binding"
}

variable "namespace" {
  type = string
}

variable "image" {
  type = string
}
