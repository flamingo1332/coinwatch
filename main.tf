terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
  }

  backend "s3" {
    bucket         = "ksw29555-coinwatch-terraform-backend"
    key            = "terraform/main.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "coinwatch-terraform-backend-lock"
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


module "backend" {
  source = "./modules/backend"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source = "./modules/lambda"

  sns_topic_arn          = module.sns_topic.sns_topic_arn
  iam_role_lambda_arn    = module.iam.iam_role_lambda_arn
  price_table_name       = module.dynamodb.price_table_name
  change_rate_table_arn  = module.dynamodb.change_rate_table_arn
  change_rate_table_name = module.dynamodb.change_rate_table_name
  cloudwatch_event_rule  = module.eventbridge.cloudwatch_event_rule
}

module "eventbridge" {
  source = "./modules/eventbridge"

  lambda_data_arn = module.lambda.lambda_data_arn
}

module "sns_topic" {
  source = "./modules/sns_topic"
}
