module "lambda_edge_role" {
  source = "./modules/iam_role"

  role_name = "0eu096k-9ci2y0p"
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
  max_session_duration = 3600
  path                 = "/"
  inline_policies      = var.inline_policies
}