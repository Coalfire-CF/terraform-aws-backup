variable "partition" {
  type        = string
  description = "The AWS partition to use"
}

variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "enable_cross_region_backup" {
  description = "Enable cross-region backup functionality"
  type        = bool
  default     = false
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

variable "secondary_region_backup_kms_arn" {
  description = "KMS key ARN in secondary region for backup encryption"
  type        = string
  default     = null
}

variable "delete_after" {
  description = "Delete backups after defined number of days"
  type =  number
  default = 14
}

variable "backup_rule_name" {
  description = "AWS backup rule name"
  type = string
}

variable "backup_vault_name" {
  description = "AWS backup vault name"
  type = string
}

variable "backup_plan_name" {
  description = "AWS backup plan name"
  type = string
}

variable "backup_schedule" {
  description = "AWS backup cron schedule"
  type = string
  default = "cron(0 3 ? * * *)"
}

variable "backup_selection_tag_value" {
  description = "AWS backup selection tag value"
  type = string
  default = "aws-backup-minimum-compliance" # DO NOT CHANGE UNLESS YOU PLAN TO CHANGE TAGGING ON ALL RESOURCES
}
