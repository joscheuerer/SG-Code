module "vpc" {
  source = "./modules/vpc"

  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpc_name"
  }
}

module "subnet" {
  source = "./modules/subnet"

  availability_zone       = "eu-central-1a"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = module.vpc.vpc_id
  tags = {
    Name = "vpc_name-public-eu-central-1a"
  }
}

module "security_group" {
  source = "./modules/security_group"

  description   = "Security group for EC2 instance - SSH access"
  group_name    = "ec2-sg-3hgs1rry"
  vpc_id        = module.vpc.vpc_id
  egress_rules  = var.egress_rules
  ingress_rules = var.ingress_rules
}

module "ebs_volume" {
  source = "./modules/ebs_volume"

  availability_zone = "eu-central-1a"
  encrypted         = false
  iops              = 3000
  size              = 20
  snapshot_id       = "snap-06fcd4dec42bceeff"
  throughput        = 125
  volume_type       = "gp3"
}

module "instance" {
  source = "./modules/instance"

  ami_id                               = "ami-074dd8e8dac7651a5"
  availability_zone                    = "eu-central-1a"
  capacity_reservation_preference      = "open"
  cpu_core_count                       = 1
  cpu_threads_per_core                 = 2
  ebs_optimized                        = false
  enclave_enabled                      = false
  hibernation                          = false
  instance_type                        = "t3.medium"
  key_name                             = "ec2-key-3hgs1rry"
  metadata_http_endpoint               = "enabled"
  metadata_http_put_response_hop_limit = 1
  metadata_http_tokens                 = "optional"
  metadata_instance_metadata_tags      = "disabled"
  monitoring                           = false
  root_delete_on_termination           = true
  root_volume_iops                     = 3000
  root_volume_size                     = 20
  root_volume_throughput               = 125
  root_volume_type                     = "gp3"
  source_dest_check                    = true
  subnet_id                            = module.subnet.subnet_id
  tenancy                              = "default"
  vpc_security_group_ids               = [module.security_group.security_group_id]
}