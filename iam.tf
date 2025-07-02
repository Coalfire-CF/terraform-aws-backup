resource "aws_iam_role" "backup-iam-role" {
  provider = aws.primary

  name               = "${var.resource_prefix}-backup-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

data "aws_iam_policy_document" "backups-pass-role-policy" {
  provider = aws.primary

  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["arn:${var.partition}:iam::${var.account_number}:role/*"]
  }
}

resource "aws_iam_role_policy" "backups-pass-role" {
  provider = aws.primary

  policy = data.aws_iam_policy_document.backups-pass-role-policy.json
  role   = aws_iam_role.backup-iam-role.id

  depends_on = [aws_iam_role.backup-iam-role]
}

resource "aws_iam_role_policy_attachment" "backup-restores-iam-attach" {
  provider = aws.primary

  role       = aws_iam_role.backup-iam-role.name
  policy_arn = "arn:${var.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"

  depends_on = [aws_iam_role.backup-iam-role]

}

resource "aws_iam_role_policy_attachment" "backup-backups-iam-attach" {
  provider = aws.primary

  role       = aws_iam_role.backup-iam-role.name
  policy_arn = "arn:${var.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"

  depends_on = [aws_iam_role.backup-iam-role]
}

resource "aws_iam_role_policy_attachment" "backup-s3-backups-iam-attach" {
  provider = aws.primary

  role       = aws_iam_role.backup-iam-role.name
  policy_arn = "arn:${var.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForS3Backup"

  depends_on = [aws_iam_role.backup-iam-role]
}

data "aws_iam_policy_document" "backups-cross-region-policy" {
  provider   = aws.secondary

  count = var.enable_cross_region_backup ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "backup:CopyIntoBackupVault"
    ]
    resources = [
      aws_backup_vault.secondary-backup-vault[0].arn
    ]
  }
}

resource "aws_iam_role_policy" "backups-cross-region" {
  provider   = aws.secondary

  count  = var.enable_cross_region_backup ? 1 : 0

  policy = data.aws_iam_policy_document.backups-cross-region-policy[0].json
  role   = aws_iam_role.backup-iam-role.id
}
