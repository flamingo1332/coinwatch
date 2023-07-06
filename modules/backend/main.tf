# terraform backend bucket
resource "aws_s3_bucket" "terraform_backend_bucket" {
  bucket = var.s3_bucket_name_terraform_backend

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_backend_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_backend_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_dynamodb_table" "terraform_backend_lock" {
  name           = var.dynamodb_name_terraform_backend_lock
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }


}
