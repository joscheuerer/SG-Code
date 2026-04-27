module "iam_role" {
  source = "./modules/iam_role"

  assume_role_policy   = var.iam_role_assume_role_policy
  inline_policies      = var.iam_role_inline_policies
  managed_policy_arns  = var.iam_role_managed_policy_arns
  max_session_duration = var.iam_role_max_session_duration
  name                 = var.iam_role_name
  path                 = var.iam_role_path
  tags                 = var.iam_role_tags
}

module "s3_bucket" {
  source   = "./modules/s3_bucket"
  for_each = var.s3_buckets

  bucket = each.value.bucket
  tags   = each.value.tags
}