resource "aws_cloudwatch_event_rule" "lambda_invocation_15min" {
  name        = var.cloudwatch_event_rule_name

  schedule_expression = "rate(15 minutes)"
  is_enabled = true
  
#   defulat event bus
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.lambda_invocation_15min.name
  target_id = "invokeLambda"
  arn       = var.lambda_data_arn
}
