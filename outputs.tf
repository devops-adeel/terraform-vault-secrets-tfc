output "backend_path" {
  description = "Secrets Backend Path as output"
  value       = vault_terraform_cloud_secret_backend.default.backend
}

output "identity_group_id" {
  description = "ID of the created Vault Identity Group."
  value       = vault_identity_group.default.id
  sensitive   = true
}
