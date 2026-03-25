module "bucket_2dlru2rs" {
  source = "./modules/s3_bucket"

  bucket_name             = "2dlru2rs-private-runner-storage-backend"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  object_ownership        = "BucketOwnerEnforced"
  sse_algorithm           = "AES256"
  bucket_key_enabled      = false
}

module "bucket_37lxrdhe" {
  source = "./modules/s3_bucket"

  bucket_name             = "37lxrdhe-private-runner-storage-backend"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  object_ownership        = "BucketOwnerEnforced"
  sse_algorithm           = "AES256"
  bucket_key_enabled      = false
}