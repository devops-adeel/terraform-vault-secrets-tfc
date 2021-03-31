locals {
  app_prd = "team-prd"
  app_dev = "team-dev"
  env_prd = "prd"
  env_dev = "dev"
  service = "web"
}

module "default" {
  source = "./module"
  token  = var.token
}

data "vault_auth_backend" "default" {
  path = "approle"
}

####
## Example of prod deployment in same namespace, using the same Vault ACL Policy
####

module "prd" {
  source            = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.7.0"
  application_name  = local.app_prd
  env               = local.env_prd
  service           = local.service
  mount_accessor    = data.vault_auth_backend.default.accessor
  identity_group_id = module.default.identity_group_id
}

resource "tfe_team" "prd" {
  name         = local.app_prd
  organization = var.organization
}

resource "vault_terraform_cloud_secret_role" "prd" {
  backend      = module.default.backend_path
  name         = local.app_prd
  organization = var.organization
  team_id      = tfe_team.prd.id
}


####
## Example of dev deployment in same namespace, using the same Vault ACL Policy
####

module "dev" {
  source            = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.7.0"
  application_name  = local.app_dev
  env               = local.env_dev
  service           = local.service
  mount_accessor    = data.vault_auth_backend.default.accessor
  identity_group_id = module.default.identity_group_id
}

resource "tfe_team" "dev" {
  name         = local.app_dev
  organization = var.organization
}

resource "vault_terraform_cloud_secret_role" "dev" {
  backend      = module.default.backend_path
  name         = local.app_dev
  organization = var.organization
  team_id      = tfe_team.dev.id
}

resource "vault_approle_auth_backend_login" "default" {
  backend   = data.vault_auth_backend.default.path
  role_id   = module.dev.approle_id
  secret_id = module.dev.approle_secret
}
