variable "s3_bucket_name_terraform_backend" {
  description = "s3 bucket name for terraform backend"
  type        = string
  default     = "ksw29555-coinwatch-terraform-backend"
}


variable "dynamodb_name_terraform_backend_lock" {
  description = "terraform-backend-lock"
  type        = string
  default     = "coinwatch-terraform-backend-lock"
}
