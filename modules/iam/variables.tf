variable "iam_lambda_role_name" {
  description = "name of iam role for lambda"
  type        = string
  default     = "LambdaRoleForCoiwnatch"
}


variable "iam_role_lambda_policy" {
  type    = string
  default = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
