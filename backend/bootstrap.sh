#!/bin/bash
set -e

echo "🚀 Initializing Bootstrap Terraform..."
terraform init

echo "🏗️  Creating S3 and DynamoDB for Remote State..."
terraform apply -auto-approve

echo "✅ Backend infrastructure ready."
echo "⚠️  Keep the 'terraform.tfstate' file generated in this folder safe," 
echo "   or delete this folder once you verify the resources in AWS Console."