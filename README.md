![inspec-test](https://github.com/devops-adeel/terraform-vault-secrets-tfc/actions/workflows/terraform-apply.yml/badge.svg)

## Terraform Vault Secrets TFC Module

This terraform module mounts the secret backend for terraform-cloud-secrets and
bind an ACL templated policy.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Usage:

```hcl

module "vault_tfc_secrets" {
  source      = "git::https://github.com/devops-adeel/terraform-vault-secrets-tfc.git?ref=v0.4.0"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 2.19.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | ~> 2.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_identity_group.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_identity_group_policies.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group_policies) | resource |
| [vault_policy.admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_terraform_cloud_secret_backend.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/terraform_cloud_secret_backend) | resource |
| [vault_policy_document.admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |
| [vault_policy_document.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_token"></a> [token](#input\_token) | TFC token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_path"></a> [backend\_path](#output\_backend\_path) | Secrets Backend Path as output |
| <a name="output_identity_group_id"></a> [identity\_group\_id](#output\_identity\_group\_id) | ID of the created Vault Identity Group. |
| <a name="output_tfc_admin_policy_name"></a> [tfc\_admin\_policy\_name](#output\_tfc\_admin\_policy\_name) | Name of the terraform admin policy |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
