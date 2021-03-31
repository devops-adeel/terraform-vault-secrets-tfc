## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.24.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default"></a> [default](#module\_default) | ./module |  |
| <a name="module_dev"></a> [dev](#module\_dev) | git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.7.0 |  |
| <a name="module_prd"></a> [prd](#module\_prd) | git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.7.0 |  |

## Resources

| Name | Type |
|------|------|
| [tfe_team.dev](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_team.prd](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [vault_approle_auth_backend_login.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_login) | resource |
| [vault_terraform_cloud_secret_role.dev](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/terraform_cloud_secret_role) | resource |
| [vault_terraform_cloud_secret_role.prd](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/terraform_cloud_secret_role) | resource |
| [vault_auth_backend.default](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/auth_backend) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_approle_id"></a> [approle\_id](#input\_approle\_id) | The Approle ID for this workspace | `string` | n/a | yes |
| <a name="input_approle_secret"></a> [approle\_secret](#input\_approle\_secret) | The Approle Secret for this workspace | `string` | n/a | yes |
| <a name="input_email"></a> [email](#input\_email) | TFC User Email Address | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | TFC Org | `string` | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | TFC Token | `string` | n/a | yes |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | Vault Address | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_path_dev"></a> [path\_dev](#output\_path\_dev) | n/a |
| <a name="output_path_prd"></a> [path\_prd](#output\_path\_prd) | n/a |
| <a name="output_token"></a> [token](#output\_token) | n/a |
| <a name="output_url"></a> [url](#output\_url) | n/a |
