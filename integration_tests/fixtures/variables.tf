variable "vault_address" {
  description = "Vault Address"
  type        = string
}

variable "token" {
  description = "TFC Token"
  type        = string
  sensitive   = true
}

variable "organization" {
  description = "TFC Org"
  type        = string
}

variable "email" {
  description = "TFC User Email Address"
  type        = string
}

variable "username" {
  description = "Terraform username"
  type        = string
  default     = "devops-adeel"
}
