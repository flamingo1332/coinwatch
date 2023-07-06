resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
  fifo_topic = false
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.email
}