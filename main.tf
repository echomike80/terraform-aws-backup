data "aws_caller_identity" "current" {
}

resource "aws_iam_role" "this" {
  count                 = var.enabled && var.create_role ? 1 : 0
  name                  = var.role_name

  assume_role_policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "backup.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "backup" {
  count         = var.enabled && var.create_role ? 1 : 0
  role          = aws_iam_role.this[0].name
  policy_arn    = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "restores" {
  count         = var.enabled && var.create_role ? 1 : 0
  role          = aws_iam_role.this[0].name
  policy_arn    = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

resource "aws_backup_vault" "this" {
  count         = var.enabled ? 1 : 0
  name          = format("%s-vault", var.name)
  kms_key_arn   = var.vault_kms_key_arn
}

resource "aws_backup_plan" "this" {
  count         = var.enabled ? 1 : 0
  name          = format("%s-plan", var.name)

  rule {
    rule_name         = format("%s-rule", var.name)
    target_vault_name = aws_backup_vault.this[0].name
    schedule          = var.plan_schedule

    dynamic "lifecycle" {
      for_each    = var.plan_cold_storage_after != null || var.plan_delete_after != null ? ["true"] : []
      content {
        cold_storage_after    = var.plan_cold_storage_after
        delete_after          = var.plan_delete_after
      }
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = var.plan_windows_vss
    }
    resource_type = var.resource_type
  }
}

resource "aws_backup_selection" "this" {
  count         = var.enabled ? 1 : 0
  iam_role_arn  = format("arn:aws:iam::%s:role/%s", data.aws_caller_identity.current.account_id, var.role_name)
  name          = format("%s-selection", var.name)
  plan_id       = aws_backup_plan.this[0].id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.plan_tag_key
    value = var.plan_tag_value
  }
}