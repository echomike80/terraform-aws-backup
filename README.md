# AWS Backup Terraform module

Terraform module which creates an AWS Backup vault, plan, selection and rules on AWS.

## Terraform versions

Terraform 0.12 and newer. 

## Usage

```hcl
module "backup_daily" {
  source            = "/path/to/terraform-aws-backup"

  name              = format("bkp-%s-daily", var.name)
  create_role       = true
  plan_delete_after = 30
  plan_schedule     = "cron(0 3 * * ? *)"
  plan_tag_key      = "Backup"
  plan_tag_value    = "daily"
  role_name         = format("rl-%s-ec2-backup-daily", var.name, local.environment)
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.65 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.65 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.restores](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Create IAM role for AWS backup | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable or disable AWS Backup | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all resources as prefix | `string` | n/a | yes |
| <a name="input_plan_cold_storage_after"></a> [plan\_cold\_storage\_after](#input\_plan\_cold\_storage\_after) | Specifies the number of days after creation that a recovery point is moved to cold storage | `number` | `null` | no |
| <a name="input_plan_delete_after"></a> [plan\_delete\_after](#input\_plan\_delete\_after) | Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than `cold_storage_after` | `number` | `null` | no |
| <a name="input_plan_schedule"></a> [plan\_schedule](#input\_plan\_schedule) | AWS Backup plan schedule | `string` | `"cron(0 3 * * ? *)"` | no |
| <a name="input_plan_tag_key"></a> [plan\_tag\_key](#input\_plan\_tag\_key) | AWS Backup selection tag key | `string` | `"Backup"` | no |
| <a name="input_plan_tag_value"></a> [plan\_tag\_value](#input\_plan\_tag\_value) | AWS Backup selection tag value | `string` | `"enabled"` | no |
| <a name="input_plan_windows_vss"></a> [plan\_windows\_vss](#input\_plan\_windows\_vss) | AWS Backup plan Windows VSS feature | `string` | `"disabled"` | no |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | Resource type to backup | `string` | `"enabled"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the IAM role which will be created when enabled is true and create\_role is true | `string` | `"ec2-backup-role"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of backup tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_vault_kms_key_arn"></a> [vault\_kms\_key\_arn](#input\_vault\_kms\_key\_arn) | AWS Backup vault KMS key arn | `string` | `null` | no |

## Outputs

No outputs.

## Authors

Module managed by [Marcel Emmert](https://github.com/echomike80).

## License

Apache 2 Licensed. See LICENSE for full details.
