output "cloudwatch_event_rule" {
  value = aws_cloudwatch_event_rule.lambda_invocation_15min.arn
}