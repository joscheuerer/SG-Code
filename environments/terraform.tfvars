region = "us-east-1"

inline_policies = {
  policy_1 = {
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