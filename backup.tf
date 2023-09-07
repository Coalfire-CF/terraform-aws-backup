resource "aws_backup_vault" "backup-vault" {
  name        = "${var.resource_prefix}-backup-vault"
  kms_key_arn = var.backup_kms_arn
}

resource "aws_backup_plan" "default-policy-backup-plan" {

  name = "${var.resource_prefix}-default-policy-backup-plan"

  # Run backup at 3:00 AM GMT every day of the month
  rule {
    rule_name         = "daily-rule"
    target_vault_name = aws_backup_vault.backup-vault.name
    schedule          = "cron(0 3 ? * * *)"
    # Delete after 7 days (maintain daily backups for a week)
    lifecycle {
      delete_after = var.delete_after
    }
    recovery_point_tags = {
      "created-by" : "AWS Backup"
      "identifier" : "default-policy-backup-DAILY"
    }
  }
}

# Backup selection for the default policy
resource "aws_backup_selection" "default-policy-backup-selection" {

  iam_role_arn = aws_iam_role.backup-iam-role.arn
  name         = "${var.resource_prefix}-default-policy-backup-selection"
  plan_id      = aws_backup_plan.default-policy-backup-plan.id

  # You can also select resources by their ARNS -- refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup_policy"
    value = "aws-backup-${var.resource_prefix}-default-policy"
  }
}