output "backend_path" {
  description = "Secrets Backend Path as output"
  value       = vault_terraform_cloud_secret_backend.default.path
}
