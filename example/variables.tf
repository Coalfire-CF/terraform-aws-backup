variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-gov-west-1"
}

variable "profile" {
  description = "AWS profile to use for deployment"
  type        = string
  default     = "default"
}

variable "resource_prefix" {
  description = "Prefix to be used for resource naming"
  type        = string
  default     = "eric-test"
}

variable "account_id" {
  description = "AWS account ID for the management account"
  type        = string
}

variable "backup_plan_name" {
  description = "Name of the backup plan"
  type        = string
}

variable "backup_rule_name" {
  description = "Name of the backup rule"
  type        = string
}

variable "backup_vault_name" {
  description = "Name of the backup vault"
  type        = string
}

variable "partition" {
  description = "AWS partition (aws, aws-cn, aws-us-gov)"
  type        = string
  default     = "aws-us-gov"
}
