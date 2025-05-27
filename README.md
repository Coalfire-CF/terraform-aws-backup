![Coalfire](coalfire_logo.png)

# terraform-aws-backup


## Description

This Terraform module automates the deployment of AWS Backup resources, including backup vaults, backup plans, IAM roles, and policies to enable secure, compliant, and automated backups of AWS resources. It supports both single-region and cross-region backup configurations, resource selection by tags, and integration with KMS for encryption. The module is designed to help organizations meet compliance requirements such as FedRAMP High by providing a standardized, repeatable backup solution.

FedRAMP Compliance: High

## Architecture

[architecture diagram to come]

## Dependencies

List any dependencies here:

- KMS key for AWS Backup encryption
- Appropriate AWS provider configuration
- Tagged resources for backup selection

## Environment Setup

Include the required steps to establish a secure connection to AWS:

```hcl
- Download and install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

- Log into the AWS Console and [create AWS CLI Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

- Configure the named profile used for the project, such as `aws configure --profile example-mgmt`
```

## Tree
```
.
|-- CONTRIBUTING.md
|-- License.md
|-- README.md
|-- coalfire_logo.png
|-- main.tf
|-- variables.tf
|-- outputs.tf
|-- versions.tf
```

## Resource List

Resources that are created as a part of this module include:

- AWS backup vault (primary region)
- AWS backup vault (secondary region, if cross-region enabled)
- AWS backup plan with customizable rules
- AWS backup selection for tagged resources
- IAM role for backup operations
- IAM policies for backup and restore operations
- Cross-region backup policies (when enabled)

## Code Updates

`providers.tf` Update to the appropriate version and providers:

```hcl
terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

## Deployment

This section details how to deploy the AWS Backup resources:

1. Navigate to the Terraform project and create a parent directory in the upper level code, for example:

    ```hcl
    ../aws/terraform/{REGION}/management-account/backup
    ```

   If multi-account management plane:

    ```hcl
    ../aws/terraform/{REGION}/{ACCOUNT_TYPE}-mgmt-account/backup
    ```

2. Create a properly defined main.tf file via the template found under 'Usage' while adjusting tfvars as needed. Note that many provided variables are outputs from other modules. Example parent directory:

   ```hcl
   ├── backup/
   │   ├── backends/
   │   │   ├── prefix.tfvars
   │   ├── tfvars/
   │   │   ├── prefix.tfvars
   │   ├── data.tf
   │   ├── locals.tf
   │   ├── main.tf
   │   ├── outputs.tf
   │   ├── providers.tf
   │   ├── README.md
   │   ├── remote-data.tf
   │   ├── required-providers.tf
   │   ├── tstate.tf
   │   ├── variables.tf
   │   ├── ...
   ```

3. Initialize the Terraform working directory:
   ```hcl
   terraform init -backend-config=./backends/prefix.tfvars
   ```
   Create an execution plan and verify everything looks correct:
   ```hcl
   terraform plan -var-file=./tfvars/prefix.tfvars
   ```
   Apply the configuration:
   ```hcl
   terraform apply -var-file=./tfvars/prefix.tfvars
   ```

## Usage

Single-region backups (because of the way the module is written, you can simply define the same provider for both primary and secondary):

```hcl
provider "aws" {
  alias = "mgmt-gov"
  # Configuration for primary region
}

module "aws-backup" {
  source = "github.com/Coalfire-CF/terraform-aws-backup?ref=vX.X.X"

  providers = {
    aws.primary = aws.mgmt-gov
    aws.secondary = aws.mgmt-gov
  }

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

Cross-region backups (in this example, "aws.mgmt-gov" is configured for "us-gov-west-1" and "aws.mgmt-gov-dr" is configured for "us-gov-east-1"):
The KMS keys are generally regional. Even if multi-region keys are used, the ARNs will be different.

```hcl
provider "aws" {
  alias = "mgmt-gov"
  # Configuration for primary region
}

provider "aws" {
  alias = "mgmt-gov-dr"
  # Configuration for secondary region
}

module "aws-backup" {
  source = "github.com/Coalfire-CF/terraform-aws-backup?ref=vX.X.X"

  providers = {
    aws.primary = aws.mgmt-gov
    aws.secondary = aws.mgmt-gov-dr
  }

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

  # Cross-Region backup
  enable_cross_region_backup      = true
  secondary_region_backup_kms_arn = var.secondary_region_backup_kms_arn
}
```

## Post Deployment Configuration

After deployment, ensure that:

1. Resources are properly tagged with the backup selection tag value
2. KMS keys have appropriate permissions for the backup service
3. Monitor backup job status in the AWS Backup console
4. Test restore procedures to validate backup integrity

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.primary"></a> [aws.primary](#provider\_aws.primary) | ~> 5.0 |
| <a name="provider_aws.secondary"></a> [aws.secondary](#provider\_aws.secondary) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.default-policy-backup-plan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.default-policy-backup-selection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.backup-vault](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_backup_vault.secondary-backup-vault](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_iam_role.backup-iam-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.backups-cross-region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.backups-pass-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.backup-backups-iam-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.backup-restores-iam-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.backups-cross-region-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
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
| <a name="input_delete_after"></a> [delete\_after](#input\_delete\_after) | Delete backups after defined number of days | `number` | `14` | no |
| <a name="input_enable_cross_region_backup"></a> [enable\_cross\_region\_backup](#input\_enable\_cross\_region\_backup) | Enable cross-region backup functionality | `bool` | `false` | no |
| <a name="input_partition"></a> [partition](#input\_partition) | The AWS partition to use | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | The prefix for the s3 bucket names | `string` | n/a | yes |
| <a name="input_secondary_region_backup_kms_arn"></a> [secondary\_region\_backup\_kms\_arn](#input\_secondary\_region\_backup\_kms\_arn) | KMS key ARN in secondary region for backup encryption | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_vault_arn"></a> [backup\_vault\_arn](#output\_backup\_vault\_arn) | n/a |
| <a name="output_backup_vault_id"></a> [backup\_vault\_id](#output\_backup\_vault\_id) | n/a |
| <a name="output_secondary_backup_vault_arn"></a> [secondary\_backup\_vault\_arn](#output\_secondary\_backup\_vault\_arn) | n/a |
| <a name="output_secondary_backup_vault_id"></a> [secondary\_backup\_vault\_id](#output\_secondary\_backup\_vault\_id) | If using cross-region backups |
<!-- END_TF_DOCS -->

## Contributing

[Start Here](CONTRIBUTING.md)

If you're interested in contributing to our projects, please review the [Contributing Guidelines](CONTRIBUTING.md). And send an email to [our team](contributing@coalfire.com) to receive a copy of our CLA and start the onboarding process.

## License

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/license/mit/)

## Contact Us

[Coalfire](https://coalfire.com/)

### Copyright

Copyright © 2025 Coalfire Systems Inc.