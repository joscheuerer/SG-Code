region = "us-east-1"

roles = {
  "0eu096k_ing4i1"  = "0eu096k-ing4i1"
  "1z1sf45_3rieapj" = "1z1sf45-3rieapj"
}

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
  "0eu096k_ing4i1" = {
    "0eu096k_ing4i1_policy" = {
      policy_name = "0eu096k-ing4i1-policy"
      policy_document = {
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ]
            Effect   = "Allow"
            Resource = "*"
          },
          {
            Action = [
              "s3:GetObject",
              "s3:PutObject"
            ]
            Effect   = "Allow"
            Resource = "arn:aws:s3:::xstack-landing-nonprod/*"
          }
        ]
      }
    }
  }
  "1z1sf45_3rieapj" = {
    "1z1sf45_3rieapj_policy" = {
      policy_name = "1z1sf45-3rieapj-policy"
      policy_document = {
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "logs:CreateLogGroup",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ]
            Effect   = "Allow"
            Resource = "*"
          },
          {
            Action = [
              "s3:GetObject",
              "s3:PutObject"
            ]
            Effect   = "Allow"
            Resource = "arn:aws:s3:::xstack-landing-nonprod/*"
          }
        ]
      }
    }
  }
}