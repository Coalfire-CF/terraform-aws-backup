<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

# Coalfire pak README Template

## ACE-AWS-Backups

## Dependencies

- KMS key for AWS Backup

## Resource List

- AWS backup vault
- AWS backup plan
- AWS IAM for backup

## Code Updates


## Deployment Steps

This module can be called as outlined below.

- Change directories to the `reponame` directory.
- From the `terraform/azure/reponame` directory run `terraform init`.
- Run `terraform plan` to review the resources being created.
- If everything looks correct in the plan output, run `terraform apply`.

## Usage

Include example for how to call the module below with generic variables

```hcl
module "backup" {
  source                    = "github.com/Coalfire-CF/ACE-AWS-Backup?ref=vX.X.X"
  partition = var.partition
  aws_region = var.region
  account_number = var.account_id
  resource_prefix = var.resource_prefix
  backup_kms_arn = var.backup_kms_arn
  delete_after = 14
}
```

<!-- BEGIN_TF_DOCS -->

ALLOW TERRAFORM MARKDOWN GITHUB ACTION TO POPULATE THE BELOW

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|

## Modules

| Name | Source | Version |
|------|--------|---------|

## Resources

| Name | Type |
|------|------|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|

## Outputs

| Name | Description |
|------|-------------|

<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
