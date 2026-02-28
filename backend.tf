terraform {
  backend "s3" {
    bucket         = "my-tf-state-template"
    key            = "prod/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-lock" # <--- Este nombre debe existir en AWS
    encrypt        = true
  }
}