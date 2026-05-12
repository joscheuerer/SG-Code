region      = "eu-central-1"
name        = "dynamodb-table-encrypted-kms"
description = "Checks whether Amazon DynamoDB table is encrypted with AWS Key Management Service (KMS). The rule is NON_COMPLIANT if Amazon DynamoDB table is not encrypted with AWS KMS."
evaluation_mode           = "DETECTIVE"
compliance_resource_types = ["AWS::DynamoDB::Table"]
source_owner              = "AWS"
source_identifier         = "DYNAMODB_TABLE_ENCRYPTED_KMS"