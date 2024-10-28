variable "partition" {
  type        = string
  description = "The AWS partition to use"
}

variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "account_number" {
  description = "The AWS account number resources are being deployed into"
  type        = string
}

variable "resource_prefix" {
  description = "The prefix for the s3 bucket names"
  type        = string
}

variable "backup_kms_arn" {
  description = "The kms key ARN for AWS backup"
  type        = string
}

variable "delete_after" {
  description = "Delete backups after defined number of days"
  type        = number
  default     = 14
}

variable "backup_rule_name" {
  description = "AWS backup rule name"
  type        = string
}

variable "backup_vault_name" {
  description = "The name of the backup vault"
  type        = string
  default     = "default-backup-vault"
}

variable "backup_plan_name" {
  description = "The name of the backup plan"
  type        = string
  default     = "default-policy-backup-plan"
}

variable "backup_schedule" {
  description = "AWS backup cron schedule"
  type        = string
  default     = "cron(0 3 ? * * *)"
}

variable "backup_selection_tag_value" {
  description = "AWS backup selection tag value"
  type        = string
  default     = "default-policy"
}

#Complaiance Variables

variable "compliance_plan_name" {
  description = "The backup plan for minimum compliance"
  type        = string
  default     = "default-backup-plan"  # Optional: Set a default value
}

variable "weekly" {
  description = "The weekly backup plan"
  type        = string
}

variable "daily" {
  description = "The daily backup plan"
  type        = string
}

variable "compliance_selection" {
  description = "The compliance selection backup plan"
  type        = string
}

variable "compliance_aws_backup" {
  description = "The AWS backup plan"
  type        = string
}

variable "rule_name_daily" {
  description = "The name of the daily backup rule"
  type        = string
}

variable "rule_name_weekly" {
  description = "The name of the weekly backup rule"
  type        = string
}
variable "backup_policy" {
  description = "The backup policy"
  type        = string
}

variable "string_equals" {
  description = "The string equals condition"
  type        = string
}

variable "selection_tag" {
  description = "The selection tag for the backup policy"
  type        = string
}

variable "default_aws_backup" {
  description = "The AWS backup plan"
  type        = string
}

variable "identify_daily" {
  description = "The identifier for the daily backup policy"
  type        = string
}
variable "default_policy" {
  description = "The default policy for backup selection"
  type        = string
}
variable "cisco_mail_alias" {
  description = "Cisco Mail Alias"
  type        = string
}

variable "application_name" {
  description = "Application Name"
  type        = string
}

variable "data_classification_cisco" {
  description = "Data Classification Cisco"
  type        = string
}

variable "data_classification_fed" {
  description = "Data Classification Fed"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "resource_owner" {
  description = "Resource Owner"
  type        = string
}

variable "deployed_fromdir" {
  description = "Deployed From Directory"
  type        = string
}