locals {
  app_prd       = "team-prd"
  app_dev       = "team-dev"
  env_prd       = "prd"
  env_dev       = "dev"
  service       = "web"
  token         = var.token
  username      = var.username
  organization  = var.organization
  team          = "terraform-vault-auth-github"
  vault_address = data.terraform_remote_state.default.outputs.vault_public_endpoint_url
  namespace     = "admin/terraform-vault-secrets-tfc"
}

module "default" {
  source = "./module"
  token  = local.token
}

data "vault_auth_backend" "default" {
  path = "approle"
}

resource "vault_github_auth_backend" "default" {
  organization = local.team
}

module "vault_github_team" {
  source         = "git::https://github.com/devops-adeel/terraform-vault-auth-github.git?ref=v0.1.0"
  github_team    = local.team
  env            = local.env_prd
  service        = local.service
  mount_accessor = vault_github_auth_backend.default.accessor
  policies       = [module.default.tfc_admin_policy_name]
}

####
## Example of prod deployment in same namespace, using the same Vault ACL Policy
####

module "prd_approle" {
  source            = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.7.0"
  application_name  = local.app_prd
  env               = local.env_prd
  service           = local.service
  mount_accessor    = data.vault_auth_backend.default.accessor
  identity_group_id = module.vault_static_secrets.identity_group_id
}

module "vault_static_secrets" {
  source = "git::https://github.com/devops-adeel/terraform-vault-secrets-kv.git?ref=v0.3.0"
}

module "prd_workspace" {
  source               = "git::https://github.com/devops-adeel/terraform-tfc-workspace.git?ref=v0.1.0"
  application_name     = local.app_prd
  vault_namespace      = local.namespace
  username             = local.username
  vault_address        = local.vault_address
  organization         = local.organization
  vault_approle_id     = module.prd_approle.approle_id
  vault_approle_secret = module.prd_approle.approle_secret
  backend_path         = module.default.backend_path
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
  organization = local.organization
}

resource "vault_terraform_cloud_secret_role" "dev" {
  backend      = module.default.backend_path
  name         = local.app_dev
  organization = local.organization
  team_id      = tfe_team.dev.id
}

resource "vault_approle_auth_backend_login" "default" {
  backend   = data.vault_auth_backend.default.path
  role_id   = module.dev.approle_id
  secret_id = module.dev.approle_secret
}
