module "private_runner_storage" {
  source = "./modules/s3_bucket"

  bucket_name             = "41n9oxq3-private-runner-storage-backend"
  object_ownership        = "BucketOwnerEnforced"
  sse_algorithm           = "AES256"
  bucket_key_enabled      = false
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  versioning_status       = "Disabled"
}