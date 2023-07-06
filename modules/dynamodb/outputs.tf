output "price_table_name" {
  value = aws_dynamodb_table.price_table.name
}
output "change_rate_table_name" {
  value = aws_dynamodb_table.change_rate_table.name
}