terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
    tfe = {
      version = "~> 0.24.0"
    }
  }
  backend "remote" {
    organization = "hc-implementation-services"

    workspaces {
      name = "terraform-vault-secrets-tfc"
    }
  }
}

variable "approle_id" {
  description = "The Approle ID for this workspace"
  type        = string
  sensitive   = true
}
variable "approle_secret" {
  description = "The Approle Secret for this workspace"
  type        = string
  sensitive   = true
}

provider "vault" {
  auth_login {
    namespace = "admin/terraform-vault-secrets-tfc"
    path      = "auth/approle/login"

    parameters = {
      role_id   = var.approle_id
      secret_id = var.approle_secret
    }
  }
}

