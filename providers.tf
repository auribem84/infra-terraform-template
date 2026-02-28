terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "my-tf-state-template"
    key            = "prod/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}