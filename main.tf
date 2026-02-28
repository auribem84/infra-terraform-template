resource "aws_s3_bucket" "webapp_assets" {
  bucket = "my-unique-webapp-assets-2026"

  tags = {
    Name        = "Web Assets"
    Environment = "Prod"
  }
}