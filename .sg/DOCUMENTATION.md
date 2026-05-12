# aws-config-rule-dynamodb-encrypted-kms

## Description

AWS Config rule that checks whether Amazon DynamoDB tables are encrypted with AWS KMS. The rule evaluates DynamoDB tables and marks them as NON_COMPLIANT if they are not encrypted with AWS Key Management Service (KMS).

## Stack Overview

| Module | Description |
|--------|-------------|
| `config_config_rule` | Manages the AWS Config rule for DynamoDB KMS encryption compliance |

## Module Details

### config_config_rule (`./modules/config_config_rule`)

Deploys an `aws_config_config_rule` resource that uses the AWS-managed rule `DYNAMODB_TABLE_ENCRYPTED_KMS` to evaluate whether DynamoDB tables are encrypted with KMS.

## Variables Reference

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `region` | `string` | AWS region where resources will be deployed | — |
| `name` | `string` | The name of the AWS Config rule | — |
| `description` | `string` | Description of the AWS Config rule | — |
| `evaluation_mode` | `string` | The mode of evaluation for the Config rule | — |
| `compliance_resource_types` | `list(string)` | A list of resource types that trigger evaluation for the rule | — |
| `source_owner` | `string` | Indicates whether AWS or the customer owns and manages the Config rule | — |
| `source_identifier` | `string` | For AWS Config managed rules, the predefined identifier | — |

## Outputs Reference

| Name | Description |
|------|-------------|
| `rule_id` | The ID of the Config rule |
| `arn` | The ARN of the Config rule |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import Existing Resources

```sh
./imports.sh terraform
# or for OpenTofu:
./imports.sh tofu
```

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```

## Notes

- This stack manages an existing AWS Config rule. The `imports.sh` script imports the rule into Terraform state before applying.
- The rule uses the AWS-managed identifier `DYNAMODB_TABLE_ENCRYPTED_KMS` and evaluates resources of type `AWS::DynamoDB::Table`.
- Evaluation mode is set to `DETECTIVE`, meaning the rule evaluates resources after configuration changes are recorded.