#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.iam_role.aws_iam_role.this' 'non-prod-file-processor-lambda-role'
"$1" import -var-file environments/sg.tfvars 'module.s3_bucket["non_prod_infra_athena_results"].aws_s3_bucket.this' 'non-prod-infra-athena-results'
"$1" import -var-file environments/sg.tfvars 'module.s3_bucket["non_prod_infra_lake_bronze"].aws_s3_bucket.this' 'non-prod-infra-lake-bronze'
"$1" import -var-file environments/sg.tfvars 'module.s3_bucket["non_prod_infra_lake_gold"].aws_s3_bucket.this' 'non-prod-infra-lake-gold'
"$1" import -var-file environments/sg.tfvars 'module.s3_bucket["non_prod_infra_lake_silver"].aws_s3_bucket.this' 'non-prod-infra-lake-silver'
"$1" import -var-file environments/sg.tfvars 'module.s3_bucket["non_prod_infra_landing_raw"].aws_s3_bucket.this' 'non-prod-infra-landing-raw'