# ecr repo for lambda
resource "aws_ecr_repository" "repository" {
  name = "coinwatch-repo"
}

resource "aws_lambda_function" "lambda_data" {
  function_name = var.lambda_visitor_name
  # runtime       = "python3.10"
  # handler       = "lambda_function.lambda_handler"
  role          = var.iam_role_lambda_arn
  image_uri     = "${aws_ecr_repository.repository.repository_url}:latest"
  package_type  = "Image"
  timeout       = 30
  environment {
    variables = {
      TABLE_NAME = var.price_table_name
      TABLE_NAME_CHANGERATE = var.change_rate_table_name
    }
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_data.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_event_rule
}

resource "aws_lambda_function_event_invoke_config" "invoke_lambda" {
  function_name = aws_lambda_function.lambda_data.function_name

  destination_config {
    on_success {
      destination = aws_lambda_function.lambda_publish.arn
    }
  }
}


resource "aws_lambda_function" "lambda_publish" {
  function_name = var.lambda_slack_notification_name
  runtime       = "python3.10"
  handler       = "lambda_function_publish.lambda_handler"
  role          = var.iam_role_lambda_arn
  filename      = "scripts/lambda_function_publish.zip"
  
  environment {
    variables = {
      TOPIC_ARN = var.sns_topic_arn
      TABLE_NAME_CHANGERATE = var.change_rate_table_name
    }
  }
}


resource "aws_lambda_permission" "allow_lambda" {
  statement_id  = "AllowExecutionLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_publish.function_name
  principal     = "lambda.amazonaws.com"
  source_arn    = aws_lambda_function.lambda_data.arn
}