region = "eu-central-1"

iam_role_name                = "non-prod-file-processor-lambda-role"
iam_role_path                = "/"
iam_role_max_session_duration = 3600
iam_role_assume_role_policy  = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
iam_role_managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

iam_role_inline_policies = {
  lambda_s3_sqs_access = {
    policy_name     = "LambdaS3SQSAccess"
    policy_document = "{\"Statement\":[{\"Action\":[\"s3:GetObject\",\"s3:PutObject\",\"s3:DeleteObject\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:s3:::non-prod-infra-landing-raw/*\",\"arn:aws:s3:::non-prod-infra-lake-bronze/*\"]},{\"Action\":[\"s3:ListBucket\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:s3:::non-prod-infra-landing-raw\",\"arn:aws:s3:::non-prod-infra-lake-bronze\"]},{\"Action\":[\"sqs:ReceiveMessage\",\"sqs:DeleteMessage\",\"sqs:GetQueueAttributes\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:sqs:eu-central-1:790543352839:non-prod-landing-ingest-queue\"},{\"Action\":[\"logs:CreateLogGroup\",\"logs:CreateLogStream\",\"logs:PutLogEvents\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:logs:eu-central-1:790543352839:*\"}],\"Version\":\"2012-10-17\"}"
  }
  non_prod_file_processor_lambda_role_policy = {
    policy_name     = "non-prod-file-processor-lambda-role-policy"
    policy_document = "{\"Statement\":[{\"Action\":[\"logs:PutLogEvents\",\"logs:CreateLogStream\",\"logs:CreateLogGroup\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:logs:eu-central-1:790543352839:log-group:/aws/lambda/non-prod-*:*\",\"arn:aws:logs:eu-central-1:790543352839:log-group:/aws/lambda/non-prod-*\"],\"Sid\":\"CloudWatchLogs\"},{\"Action\":[\"s3:ListBucket\",\"s3:HeadObject\",\"s3:GetObjectVersion\",\"s3:GetObject\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:s3:::non-prod-infra-landing-raw/*\",\"arn:aws:s3:::non-prod-infra-landing-raw\",\"arn:aws:s3:::non-prod-infra-lake-silver/*\",\"arn:aws:s3:::non-prod-infra-lake-silver\",\"arn:aws:s3:::non-prod-infra-lake-gold/*\",\"arn:aws:s3:::non-prod-infra-lake-gold\",\"arn:aws:s3:::non-prod-infra-lake-bronze/*\",\"arn:aws:s3:::non-prod-infra-lake-bronze\",\"arn:aws:s3:::non-prod-infra-athena-results/*\",\"arn:aws:s3:::non-prod-infra-athena-results\"],\"Sid\":\"S3ReadAccess\"},{\"Action\":[\"s3:PutObjectAcl\",\"s3:PutObject\",\"s3:CopyObject\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:s3:::non-prod-infra-lake-bronze/*\",\"Sid\":\"S3WriteBronze\"},{\"Action\":[\"s3:PutObject\",\"s3:DeleteObject\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:s3:::non-prod-infra-lake-silver/*\",\"arn:aws:s3:::non-prod-infra-lake-gold/*\"],\"Sid\":\"S3WriteSilverGold\"},{\"Action\":[\"sqs:ReceiveMessage\",\"sqs:GetQueueAttributes\",\"sqs:DeleteMessage\",\"sqs:ChangeMessageVisibility\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:sqs:eu-central-1:790543352839:non-prod-landing-ingest-queue\",\"arn:aws:sqs:eu-central-1:790543352839:non-prod-bronze-ingest-queue\"],\"Sid\":\"SQSAccess\"},{\"Action\":[\"athena:StopQueryExecution\",\"athena:StartQueryExecution\",\"athena:GetWorkGroup\",\"athena:GetQueryResults\",\"athena:GetQueryExecution\",\"athena:BatchGetQueryExecution\"],\"Effect\":\"Allow\",\"Resource\":\"arn:aws:athena:eu-central-1:790543352839:workgroup/non-prod-primary-workgroup\",\"Sid\":\"AthenaQueryExecution\"},{\"Action\":[\"glue:UpdateTable\",\"glue:GetTables\",\"glue:GetTable\",\"glue:GetPartitions\",\"glue:GetPartition\",\"glue:GetDatabases\",\"glue:GetDatabase\",\"glue:CreateTable\",\"glue:CreatePartition\",\"glue:BatchGetPartition\",\"glue:BatchCreatePartition\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:glue:eu-central-1:790543352839:table/non_prod_data_lake/*\",\"arn:aws:glue:eu-central-1:790543352839:database/non_prod_data_lake\",\"arn:aws:glue:eu-central-1:790543352839:catalog\"],\"Sid\":\"GlueCatalogAccess\"},{\"Action\":[\"s3:PutObject\",\"s3:ListBucketMultipartUploads\",\"s3:ListBucket\",\"s3:GetObject\",\"s3:GetBucketLocation\",\"s3:AbortMultipartUpload\"],\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:s3:::non-prod-infra-athena-results/*\",\"arn:aws:s3:::non-prod-infra-athena-results\"],\"Sid\":\"S3WriteAthenaResults\"}],\"Version\":\"2012-10-17\"}"
  }
}

iam_role_tags = {
  DataRetention = "short-term"
  Project       = "data-lake"
  ManagedBy     = "terraform"
  Architecture  = "medallion"
  CostCenter    = "non-prod-data-lake"
  Environment   = "non-prod"
  Purpose       = "lambda-execution"
}

s3_buckets = {
  non_prod_infra_athena_results = {
    bucket = "non-prod-infra-athena-results"
    tags = {
      DataRetention      = "short-term"
      Project            = "data-lake"
      ManagedBy          = "terraform"
      Architecture       = "medallion"
      CostCenter         = "non-prod-data-lake"
      DataClassification = "temporary"
      Environment        = "non-prod"
      Purpose            = "athena-query-outputs"
    }
  }
  non_prod_infra_lake_bronze = {
    bucket = "non-prod-infra-lake-bronze"
    tags = {
      DataRetention      = "short-term"
      Project            = "data-lake"
      ManagedBy          = "terraform"
      Architecture       = "medallion"
      CostCenter         = "non-prod-data-lake"
      DataClassification = "raw-validated"
      Environment        = "non-prod"
      Purpose            = "raw-data-permanent-storage"
      Layer              = "bronze"
    }
  }
  non_prod_infra_lake_gold = {
    bucket = "non-prod-infra-lake-gold"
    tags = {
      DataRetention      = "short-term"
      Project            = "data-lake"
      ManagedBy          = "terraform"
      Architecture       = "medallion"
      CostCenter         = "non-prod-data-lake"
      DataClassification = "business-ready"
      Environment        = "non-prod"
      Purpose            = "aggregated-analytics"
      Layer              = "gold"
    }
  }
  non_prod_infra_lake_silver = {
    bucket = "non-prod-infra-lake-silver"
    tags = {
      DataRetention      = "short-term"
      Project            = "data-lake"
      ManagedBy          = "terraform"
      Architecture       = "medallion"
      CostCenter         = "non-prod-data-lake"
      DataClassification = "processed"
      Environment        = "non-prod"
      Purpose            = "normalized-iceberg-tables"
      Layer              = "silver"
    }
  }
  non_prod_infra_landing_raw = {
    bucket = "non-prod-infra-landing-raw"
    tags = {
      DataRetention      = "short-term"
      Project            = "data-lake"
      ManagedBy          = "terraform"
      Architecture       = "medallion"
      CostCenter         = "non-prod-data-lake"
      DataClassification = "raw-unvalidated"
      Environment        = "non-prod"
      Purpose            = "temporary-ingestion-buffer"
      Layer              = "landing"
    }
  }
}