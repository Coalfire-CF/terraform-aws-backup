output "backup_vault_id" {
  value = aws_backup_vault.backup-vault.id
}

output "backup_vault_arn" {
  value = aws_backup_vault.backup-vault.arn
}

# If using cross-region backups
output "secondary_backup_vault_id" {
  value = try(aws_backup_vault.secondary-backup-vault[0].id, null)
}

output "secondary_backup_vault_arn" {
  value = try(aws_backup_vault.secondary-backup-vault[0].arn, null)
}