output "token" {
  value = vault_approle_auth_backend_login.default.client_token
}

output "url" {
  value = var.vault_address
}

output "namespace" {
  value = "admin/terraform-vault-secrets-tfc/"
}

output "path_dev" {
  value = format("terraform/creds/%s", local.app_dev)
}

output "path_prd" {
  value = format("terraform/creds/%s", local.app_prd)
}
