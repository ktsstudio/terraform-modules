terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "~> 3.6.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.22.1"
    }
  }
}
