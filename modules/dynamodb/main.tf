resource "aws_dynamodb_table" "price_table" {
  name         = var.price_table_name
  billing_mode = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key     = "coin"
  range_key    = "details"
  attribute {
    name = "coin"
    type = "S"
  }

  attribute {
    name = "details"
    type = "S"
  }

  # ttl {
  #   enabled        = true
  # }
}

resource "aws_dynamodb_table" "change_rate_table" {
  name         = var.change_rate_table_name
  billing_mode = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key     = "coin"
  range_key    = "change_rate"

  attribute {
    name = "coin"
    type = "S"
  }
  attribute {
    name = "datetime"
    type = "S"
  }
  attribute {
    name = "change_rate"
    type = "S"
  }

  local_secondary_index {
    name               = "LSI1"
    range_key          = "datetime"
    projection_type    = "ALL"
  }
}