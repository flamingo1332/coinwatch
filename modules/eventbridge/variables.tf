variable "cloudwatch_event_rule_name" {
  description = "cloudwatch event rule name"
  type        = string
  default     = "lambda_invocation_15min"
}

variable "s3_bucket_name_terraform_backend" {
  description = "s3 bucket name for terraform backend"
  type        = string
  default     = "ksw29555-coinwatch-terraform-backend"
}

variable "lambda_data_arn" {
  type = string
}