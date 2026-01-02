terraform {
  required_version = ">= 1.8.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.30.0" }
    random = { source = "hashicorp/random", version = ">= 3.6.0" }
  }
}

provider "aws" { region = var.aws_region }

variable "aws_region" { type = string  default = "us-east-1" }
variable "project_name" { type = string default = "ai-security-governance-framework" }
variable "environment" { type = string default = "dev" }

resource "random_id" "suffix" { byte_length = 4 }

module "network" {
  source       = "../modules/network"
  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}

module "rag_bucket" {
  source       = "../modules/s3_rag_bucket"
  project_name = var.project_name
  environment  = var.environment
  bucket_name  = "${var.project_name}-${var.environment}-rag-data-${random_id.suffix.hex}"
}

output "vpc_id" { value = module.network.vpc_id }
output "rag_bucket" { value = module.rag_bucket.bucket_name }
