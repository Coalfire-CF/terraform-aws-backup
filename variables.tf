variable "partition" {
  type        = string
  description = "The AWS partition to use"
}

variable "aws_region" {
  description = "The AWS region to create things in"
  type        = string
}


variable "is_gov" {
  description = "Whether or not resources will be deployed in a govcloud region"
  type        = bool
}

locals {
  gov = var.is_gov ? "aws-us-gov" : "aws"
}

locals {
  partition = var.is_gov ? "aws-us-gov" : "aws"
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
  description = "delete backups after defined number of days"
  type =  number
}