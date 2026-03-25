# Lambda@Edge IAM Role Infrastructure

## Overview
This Terraform configuration manages an IAM role designed for Lambda@Edge functions with appropriate permissions for CloudWatch Logs and S3 access.

## Resources
- **IAM Role**: `0eu096k-9ci2y0p`
  - Trusted entities: lambda.amazonaws.com, edgelambda.amazonaws.com
  - Max session duration: 3600 seconds
  
- **Inline Policy**: `0eu096k-9ci2y0p-policy`
  - CloudWatch Logs permissions (CreateLogGroup, CreateLogStream, PutLogEvents)
  - S3 permissions (GetObject, PutObject) for bucket `xstack-landing-nonprod`

## Module Structure
- `modules/iam_role`: Reusable module for creating IAM roles with inline policies

## Deployment
Resources are imported from existing AWS infrastructure using the import script.