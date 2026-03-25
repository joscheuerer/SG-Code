module "storage_backend" {
  source = "./modules/s3_bucket"

  bucket_name = "41n9oxq3-private-runner-storage-backend"
}

module "ebs_volume" {
  source = "./modules/ebs_volume"

  availability_zone = "eu-central-1a"
  iops              = 3000
  size              = 100
  throughput        = 125
  volume_type       = "gp3"
}

module "platform_api_eni" {
  source = "./modules/network_interface"

  description = "ELB net/platform-api-qa/db2a5cb2e2c0ca9a"
  private_ips = ["10.0.0.48"]
  subnet_id   = var.subnet_id
}