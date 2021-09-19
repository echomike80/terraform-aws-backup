variable "create_role" {
  description = "Create IAM role for AWS backup"
  type        = bool
  default     = true
}

variable "enabled" {
  description = "Enable or disable AWS Backup"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string
}

variable "plan_cold_storage_after" {
  type        = number
  description = "Specifies the number of days after creation that a recovery point is moved to cold storage"
  default     = null
}

variable "plan_delete_after" {
  type        = number
  description = "Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than `cold_storage_after`"
  default     = null
}

variable "plan_schedule" {
  description = "AWS Backup plan schedule"
  type        = string
  default     = "cron(0 3 * * ? *)"
}

variable "plan_tag_key" {
  description = "AWS Backup selection tag key"
  type        = string
  default     = "Backup"
}

variable "plan_tag_value" {
  description = "AWS Backup selection tag value"
  type        = string
  default     = "enabled"
}

variable "plan_windows_vss" {
  description = "AWS Backup plan Windows VSS feature"
  type        = string
  default     = "disabled"
}

variable "resource_type" {
  description = "Resource type to backup"
  type        = string
  default     = "EC2"
}

variable "role_name" {
  description = "Name of the IAM role which will be created when enabled is true and create_role is true"
  type        = string
  default     = "ec2-backup-role"
}

variable "tags" {
  description = "A mapping of backup tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "vault_kms_key_arn" {
  description = "AWS Backup vault KMS key arn"
  type        = string
  default     = null
}