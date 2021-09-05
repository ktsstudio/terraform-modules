terraform {
  required_providers {
    mongodb = {
      source  = "Kaginari/mongodb"
      version = "~> 0.1.2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.22.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}
