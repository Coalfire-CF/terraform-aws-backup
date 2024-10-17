account_number             = "211726082939"
aws_region                 = "us-gov-west-1"
backup_kms_arn             = "arn:aws-us-gov:kms:us-gov-west-1:211726082939:key/0a48e46c-f3ca-4574-9bac-b354163d1b29"
backup_plan_name           = "default-policy-backup-plan"
backup_rule_name           = "daily-rule"
backup_schedule            = "cron(0 3 ? * * *)"
backup_selection_tag_value = "aws-backup-default-policy"
backup_vault_name          = "backup-vault"
delete_after               = 7
partition                  = "aws-us-gov"
resource_prefix            = "cisco-stg"

########################

compliance_plan_name = "minimum-compliance-backup-plan"
weekly               = "min-compliance-backup-WEEKLY"
daily                = "min-compliance-backup-DAILY"
compliance_selection = "min-compliance-backup-selection"
compliance_aws_backup = "AWS Backup"
rule_name_daily =  "daily-rule"
rule_name_weekly =  "weekly-rule"
backup_policy   = "backup_policy"
string_equals   = "STRINGEQUALS"
selection_tag   = "aws-backup-minimum-compliance"
default_aws_backup = "AWS Backup"
identify_daily = "default-policy-backup-DAILY"
default_policy = "default-policy-backup-selection"

#Tags

cisco_mail_alias          = "gcc-fedramp-opstack@cisco.com"
application_name          = "OpsStack"
data_classification_cisco = "Cisco Confidential"
data_classification_fed   = "Direct Impact"
environment               = "stage"
resource_owner            = "dchokshi"
deployed_fromdir          = "mgmt/backup"

