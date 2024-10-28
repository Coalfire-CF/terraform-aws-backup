resource "aws_iam_role" "backup-iam-role" {

  name               = "${var.resource_prefix}-backup-role"
  tags = local.tags
  tags_all = local.tags_all

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

  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["arn:${var.partition}:iam::${var.account_number}:role/*"]
  }
}

resource "aws_iam_role_policy" "backups-pass-role" {

  policy = data.aws_iam_policy_document.backups-pass-role-policy.json
  role   = aws_iam_role.backup-iam-role.id

  depends_on = [aws_iam_role.backup-iam-role]
}

resource "aws_iam_role_policy_attachment" "backup-restores-iam-attach" {

  role       = aws_iam_role.backup-iam-role.name
  policy_arn = "arn:${var.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"

  depends_on = [aws_iam_role.backup-iam-role]

}

resource "aws_iam_role_policy_attachment" "backup-backups-iam-attach" {

  role       = aws_iam_role.backup-iam-role.name
  policy_arn = "arn:${var.partition}:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"

  depends_on = [aws_iam_role.backup-iam-role]
}