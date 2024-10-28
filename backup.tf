resource "aws_backup_vault" "backup-vault" {
  name = "${var.resource_prefix}-${var.backup_vault_name}"
  #id   = "${var.resource_prefix}-${var.backup_vault_name}"
  kms_key_arn = var.backup_kms_arn
  tags_all = local.tags_all

}

resource "aws_backup_plan" "default-policy-backup-plan" {

  name = var.backup_plan_name
  tags_all = local.tags_all
  tags = local.tags

  # Run backup at 3:00 AM GMT every day of the month
  rule {
    rule_name         = var.backup_rule_name
    target_vault_name = aws_backup_vault.backup-vault.name
    schedule          = var.backup_schedule
    # Delete after 14 days (maintain daily backups for two weeks)
    lifecycle {
      delete_after = var.delete_after
    }
    recovery_point_tags = {
      "created-by" : var.default_aws_backup
      "identifier" : var.identify_daily
    }
  }

    rule {
        completion_window        = 180
        enable_continuous_backup = false
        recovery_point_tags      = {
            "created-by" = var.default_aws_backup
            "identifier" = "default-policy-backup-MONTHLY"
        }
        rule_name                = "monthly-rule"
        schedule                 = "cron(0 0 1 * ? *)"
        start_window             = 60
        target_vault_name        = "cisco-stg-backup-vault"

        lifecycle {
            cold_storage_after = 30
            delete_after       = 120
        }
    }
    rule {
        completion_window        = 180
        enable_continuous_backup = false
        recovery_point_tags      = {
            "created-by" = var.default_aws_backup
            "identifier" = "default-policy-backup-QUARTERLY"
        }
        rule_name                = "quarterly-rule"
        schedule                 = "cron(0 0 1 */3 ? *)"
        start_window             = 60
        target_vault_name        = "cisco-stg-backup-vault"

        lifecycle {
            cold_storage_after = 90
            delete_after       = 365
        }
    }
    rule {
        completion_window        = 180
        enable_continuous_backup = false
        recovery_point_tags      = {
            "created-by" = var.default_aws_backup
            "identifier" = "default-policy-backup-MONTHLY"
        }
        rule_name                = var.rule_name_weekly
        schedule                 = "cron(0 0 ? * SUN *)"
        start_window             = 60
        target_vault_name        = "cisco-stg-backup-vault"

        lifecycle {
            delete_after = 30
        }
    }
    rule {
        completion_window        = 180
        enable_continuous_backup = false
        recovery_point_tags      = {
            "created-by" = var.default_aws_backup
            "identifier" = var.identify_daily
        }
        rule_name                = var.rule_name_daily
        schedule                 = "cron(0 3 ? * * *)"
        start_window             = 60
        target_vault_name        = "cisco-stg-backup-vault"

        lifecycle {
            delete_after = 7
        }
    }

}

# Backup selection for the default policy
resource "aws_backup_selection" "default-policy-backup-selection" {

  iam_role_arn = aws_iam_role.backup-iam-role.arn
  name         = var.default_policy
  plan_id      = aws_backup_plan.default-policy-backup-plan.id

  # You can also select resources by their ARNS -- refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection
  selection_tag {
    type  = var.string_equals
    key   = var.backup_policy
    value = var.backup_selection_tag_value
  }
}



resource "aws_backup_plan" "min-compliance-backup-plan" {
  name = var.compliance_plan_name
  tags_all = local.tags_all
  tags = local.tags
  #modified


    rule {
        completion_window        = 180
        enable_continuous_backup = false
        recovery_point_tags      = {
            "created-by" = var.compliance_aws_backup
            "identifier" = var.weekly
        }
        rule_name                = var.rule_name_weekly
        schedule                 = "cron(0 0 ? * SUN *)"
        start_window             = 60
        target_vault_name        = aws_backup_vault.backup-vault.name

        lifecycle {
            delete_after = 28
        }
    }
    rule {
        completion_window        = 180
        enable_continuous_backup = false
        recovery_point_tags      = {
            "created-by" = var.compliance_aws_backup
            "identifier" = var.daily
        }
        rule_name                = var.rule_name_daily
        schedule                 = "cron(0 3 ? * * *)"
        start_window             = 60
        target_vault_name        = aws_backup_vault.backup-vault.name

        lifecycle {
            delete_after = 4
        }
    }
}



# aws_backup_selection.min-compliance-backup-selection:
resource "aws_backup_selection" "min-compliance-backup-selection" {
    iam_role_arn  = aws_iam_role.backup-iam-role.arn
    name          = var.compliance_selection
    plan_id       = aws_backup_plan.min-compliance-backup-plan.id

    condition {
    }

    selection_tag {
        key   = var.backup_policy
        type  = var.string_equals
        value = var.selection_tag
    }
}
