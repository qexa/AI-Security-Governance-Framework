# AWS Setup Guide (Terraform + RAG Storage Baseline)

This guide helps you set up AWS credentials and run the Terraform examples safely.

## What gets created
- VPC + public subnet (demo networking)
- S3 bucket representing RAG document storage

This repo includes a drift-demo config with insecure patterns for scanning demonstrations.
Use a sandbox account.

## Prerequisites
- AWS account permissions for VPC/S3
- AWS CLI v2
- Terraform >= 1.8

## Configure credentials
Profile:
```bash
aws configure --profile ai-sec-demo
export AWS_PROFILE=ai-sec-demo
```

## Run secure baseline
```bash
cd deployments/terraform/secure
terraform init
terraform plan
terraform apply
```

## Run drift demo (intentionally insecure)
```bash
cd deployments/terraform/drift-demo
terraform init
terraform plan
terraform apply
```

## Cleanup
```bash
terraform destroy
```
