module "lambda_edge_role" {
  source = "./modules/iam_role"

  name                 = "0eu096k-9ci2y0p"
  path                 = "/"
  max_session_duration = 3600

  assume_role_policy_document = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "lambda.amazonaws.com",
            "edgelambda.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  }

  inline_policies = {
    "0eu096k_9ci2y0p_policy" = {
      policy_name = "0eu096k-9ci2y0p-policy"
      policy_document = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ]
            Resource = "*"
          },
          {
            Effect = "Allow"
            Action = [
              "s3:GetObject",
              "s3:PutObject"
            ]
            Resource = "arn:aws:s3:::xstack-landing-nonprod/*"
          }
        ]
      }
    }
  }
}