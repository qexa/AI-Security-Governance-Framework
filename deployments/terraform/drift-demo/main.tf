terraform {
  required_version = ">= 1.8.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.30.0" }
    random = { source = "hashicorp/random", version = ">= 3.6.0" }
  }
}

provider "aws" { region = var.aws_region }

variable "aws_region" { type = string default = "us-east-1" }
variable "project_name" { type = string default = "ai-security-governance-framework" }
variable "environment" { type = string default = "drift-demo" }

resource "random_id" "suffix" { byte_length = 4 }

# Intentionally insecure demo bucket (to show scanners and drift signals)
resource "aws_s3_bucket" "rag_data" {
  bucket = "${var.project_name}-${var.environment}-rag-data-${random_id.suffix.hex}"
  tags = {
    Name = "rag-data-drift-demo"
    Environment = var.environment
  }
}

# AllowPublicRead_INSECURE_DEMO_ONLY
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.rag_data.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid = "AllowPublicRead_INSECURE_DEMO_ONLY"
      Effect = "Allow"
      Principal = "*"
      Action = ["s3:GetObject"]
      Resource = ["${aws_s3_bucket.rag_data.arn}/*"]
    }]
  })
}

# NOTE: Missing aws_s3_bucket_public_access_block and encryption on purpose for drift-demo
output "rag_bucket" { value = aws_s3_bucket.rag_data.bucket }
