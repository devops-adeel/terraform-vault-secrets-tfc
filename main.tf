/**
 * Usage:
 *
 * ```hcl
 *
 * module "vault_tfc_secrets" {
 *   source      = "git::https://github.com/devops-adeel/terraform-vault-secrets-tfc.git?ref=v0.2.0"
 * }
 * ```
 */


locals {
  secret_type = "terraform"
}

resource "vault_terraform_cloud_secret_backend" "default" {
  token       = var.token
  description = "TFC Secrets Backend"
}

data "vault_policy_document" "default" {
  rule {
    path         = "${local.secret_type}/creds/{{identity.entity.metadata.application}}"
    capabilities = ["read"]
    description  = "Allow generation of tfc tokens, the end path name is the role name"
  }
  rule {
    path         = "auth/token/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "create child tokens"
  }
}

resource "vault_policy" "default" {
  name   = "${local.secret_type}-creds-tmpl"
  policy = data.vault_policy_document.default.hcl
}

resource "vault_identity_group" "default" {
  name                       = "${local.secret_type}-creds"
  type                       = "internal"
  external_policies          = true
  external_member_entity_ids = true
}

resource "vault_identity_group_policies" "default" {
  group_id  = vault_identity_group.default.id
  exclusive = false
  policies = [
    "default",
    vault_policy.default.name,
  ]
}

data "vault_policy_document" "admin" {
  rule {
    path         = "${local.secret_type}/creds/*"
    capabilities = ["read"]
    description  = "Allow generation of tfc tokens, the end path name is the role name"
  }
  rule {
    path         = "auth/token/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "create child tokens"
  }
}

resource "vault_policy" "admin" {
  name   = "${local.secret_type}-creds-admin"
  policy = data.vault_policy_document.admin.hcl
}
