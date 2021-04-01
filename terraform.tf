terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.19.0"
    }
  }
}

provider "vault" {
  # Configuration options
}
