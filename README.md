![inspec-test](https://github.com/devops-adeel/terraform-vault-secrets-tfc/actions/workflows/terraform-apply.yml/badge.svg)

## Terraform Vault Secrets TFC Module

This terraform module mounts the secret backend for terraform-cloud-secrets and
bind an ACL templated policy.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Usage:

```hcl

module "vault_tfc_secrets" {
  source      = "git::https://github.com/devops-adeel/terraform-vault-secrets-tfc.git?ref=v0.2.0"
}
```

## Requirements

| Name | Version |
|------|---------|
| vault | ~> 2.19.0 |

## Providers

| Name | Version |
|------|---------|
| vault | ~> 2.19.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| token | TFC token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| backend\_path | Secrets Backend Path as output |
| identity\_group\_id | ID of the created Vault Identity Group. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
