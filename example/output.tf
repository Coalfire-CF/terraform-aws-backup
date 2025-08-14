output "backup_vault_arn" {
  description = "The ARN of the AWS Backup vault"
  value       = module.aws-backup.backup_vault_arn
}
output "backup_vault_id" {
  description = "The ID of the AWS Backup vault"
  value       = module.aws-backup.backup_vault_id
}
output "secondary_backup_vault_id" {
  description = "The ID of the secondary AWS Backup vault"
  value       = module.aws-backup.secondary_backup_vault_id
}

output "secondary_backup_vault_arn" {
  description = "The ARN of the secondary AWS Backup vault"
  value       = module.aws-backup.secondary_backup_vault_arn
}
