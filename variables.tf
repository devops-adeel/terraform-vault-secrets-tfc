variable "entity_ids" {
  description = "List of Vault Identity Member IDs"
  type        = list(string)
  default     = []
}

variable "token" {
  description = "TFC token"
  type        = string
  sensitive   = true
}
