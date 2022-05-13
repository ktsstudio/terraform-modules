terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.73.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.22.1"
    }
  }
}
