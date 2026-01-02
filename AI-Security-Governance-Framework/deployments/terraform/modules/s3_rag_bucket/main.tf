variable "bucket_name" { type = string }
variable "environment" { type = string }
variable "project_name" { type = string }

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags = {
    Name        = "${var.project_name}-${var.environment}-rag-data"
    Environment = var.environment
    Owner       = "ai-security"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration { status = "Enabled" }
}

output "bucket_name" { value = aws_s3_bucket.this.bucket }
