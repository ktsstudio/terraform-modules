terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "3.11.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.22.1"
    }
  }
}
