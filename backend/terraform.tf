provider "aws" {
  region = "us-east-2" 
}

# 1. S3 Bucket for State Storage
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "my-tf-state-template" # Change this to a unique name
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }
}

# Enable versioning (Crucial for recovering from accidental deletes)
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 2. DynamoDB for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}