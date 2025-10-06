module "aws-backup" {
  providers = {
    aws.primary   = aws.govsandbox
    aws.secondary = aws.govsandbox
  }
  source = "../../../../modules/terraform-aws-backup"

  partition       = var.partition
  aws_region      = var.aws_region
  account_number  = var.account_id
  resource_prefix = var.resource_prefix
  backup_kms_arn  = data.terraform_remote_state.account_setup.outputs.backup_kms_key_arn
  delete_after    = 14

  backup_rule_name           = var.backup_rule_name
  backup_vault_name          = var.backup_vault_name
  backup_plan_name           = var.backup_plan_name
  backup_selection_tag_value = var.backup_selection_tag_value # DO NOT CHANGE UNLESS YOU PLAN TO CHANGE TAGGING ON ALL RESOURCES
}
