<div align="center">
<img src="coalfire_logo.png" width="200">

</div>

# AWS Backup Terraform Module

## Description

The AWS backup module creates backup resources for your project.

FedRAMP Compliance: High

## Dependencies

- KMS key for AWS Backup

## Resource List

Resources that are created as a part of this module include:

- AWS backup vault
- AWS backup plan
- AWS IAM for backup

## Deployment Steps

This module can be called as outlined below:

- Change directories to the `terraform-aws-backup` directory.
- From the `terraform-aws-backup` directory run `terraform init`.
- Run `terraform plan` to review the resources being created.
- If everything looks correct in the plan output, run `terraform apply`.

## Usage
```
module "aws-backup" {
  source = "github.com/Coalfire-CF/terraform-aws-backup"

  partition = var.partition
  aws_region = var.region
  account_number = var.account_id
  resource_prefix = var.resource_prefix
  backup_kms_arn = var.backup_kms_arn
  delete_after = 14

  backup_rule_name = var.backup_rule_name
  backup_vault_name = var.backup_vault_name
  backup_plan_name = var.backup_plan_name
  backup_selection_tag_value = var.backup_selection_tag_value

}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.default-policy-backup-plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.default-policy-backup-selection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.backup-vault](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_iam_role.backup-iam-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.backups-pass-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.backup-backups-iam-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.backup-restores-iam-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.backups-pass-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | The AWS account number resources are being deployed into | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create resources in | `string` | n/a | yes |
| <a name="input_backup_kms_arn"></a> [backup\_kms\_arn](#input\_backup\_kms\_arn) | The kms key ARN for AWS backup | `string` | n/a | yes |
| <a name="input_backup_plan_name"></a> [backup\_plan\_name](#input\_backup\_plan\_name) | AWS backup plan name | `string` | n/a | yes |
| <a name="input_backup_rule_name"></a> [backup\_rule\_name](#input\_backup\_rule\_name) | AWS backup rule name | `string` | n/a | yes |
| <a name="input_backup_schedule"></a> [backup\_schedule](#input\_backup\_schedule) | AWS backup cron schedule | `string` | `"cron(0 3 ? * * *)"` | no |
| <a name="input_backup_selection_tag_value"></a> [backup\_selection\_tag\_value](#input\_backup\_selection\_tag\_value) | AWS backup selection tag value | `string` | n/a | yes |
| <a name="input_backup_vault_name"></a> [backup\_vault\_name](#input\_backup\_vault\_name) | AWS backup vault name | `string` | n/a | yes |
| <a name="input_delete_after"></a> [delete\_after](#input\_delete\_after) | Delete backups after defined number of days | `number` | n/a | yes |
| <a name="input_partition"></a> [partition](#input\_partition) | The AWS partition to use | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the s3 bucket names | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_vault_arn"></a> [backup\_vault\_arn](#output\_backup\_vault\_arn) | n/a |
| <a name="output_backup_vault_id"></a> [backup\_vault\_id](#output\_backup\_vault\_id) | n/a |
<!-- END_TF_DOCS -->

## Contributing

[Relative or absolute link to contributing.md](CONTRIBUTING.md)


## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)


## Coalfire Pages

[Absolute link to any relevant Coalfire Pages](https://coalfire.com/)

### Copyright

Copyright © 2023 Coalfire Systems Inc.
