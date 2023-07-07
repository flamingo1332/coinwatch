variable "sns_topic_arn" {
  type = string
}
variable "iam_role_lambda_arn" {
  type = string
}
variable "price_table_name" {
  type = string
}
variable "change_rate_table_arn" {
  type = string
}
variable "change_rate_table_name" {
  type = string
}
variable "cloudwatch_event_rule" {
  type = string
}



variable "lambda_visitor_name" {
  description = "name for visitor lambda script"
  type        = string
  default     = "coinwatch_data"
}

variable "lambda_slack_notification_name" {
  description = "name for notification lambda script"
  type        = string
  default     = "coinwatch_publish"
}
