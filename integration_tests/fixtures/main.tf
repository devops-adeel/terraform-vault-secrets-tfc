locals {
  application_name = "terraform-vault-secrets-tfc"
  env              = "dev"
  service          = "web"
}

module "default" {
  source     = "./module"
  entity_ids = [module.vault_approle.entity_id]
  token      = var.token
}

data "vault_auth_backend" "default" {
  path = "approle"
}

data "tfe_organization_membership" "default" {
  organization = var.organization
  email        = var.email
}

module "vault_approle" {
  source           = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.6.1"
  application_name = local.application_name
  env              = local.env
  service          = local.service
  mount_accessor   = data.vault_auth_backend.default.accessor
}

resource "tfe_team" "default" {
  name         = local.application_name
  organization = data.tfe_organization_membership.default.organization
}

resource "vault_terraform_cloud_secret_role" "default" {
  backend      = module.default.backend_path
  name         = format("%s-%s", local.env, local.service)
  organization = data.tfe_organization_membership.default.organization
  team_id      = tfe_team.default.id
}

resource "vault_approle_auth_backend_login" "default" {
  backend   = module.vault_approle.backend_path
  role_id   = module.vault_approle.approle_id
  secret_id = module.vault_approle.approle_secret
}
