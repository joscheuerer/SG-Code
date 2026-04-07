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

  vpc_id                  = module.vpc.vpc_id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc_name-public-eu-central-1a"
  }
}

module "security_group" {
  source = "./modules/security_group"

  group_name  = "packer_68c879f3-344d-174a-2c11-4dcb15c975ed"
  description = "Temporary group for Packer"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = {
    ssh = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "178.77.15.22/32"
    }
  }
  egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}

module "ebs_volume" {
  source = "./modules/ebs_volume"

  availability_zone = var.availability_zone
  size              = 8
  volume_type       = "gp2"
  encrypted         = false
  iops              = 100
  snapshot_id       = var.snapshot_id
}

module "instance" {
  source = "./modules/instance"

  ami_id                                 = var.ami_id
  instance_type                          = var.instance_type
  availability_zone                      = var.availability_zone
  key_name                               = "packer_68c879f2-1468-642a-6776-a06c2a3c37fc"
  subnet_id                              = module.subnet.subnet_id
  security_group_ids                     = [module.security_group.security_group_id]
  ebs_optimized                          = false
  monitoring                             = false
  source_dest_check                      = true
  tenancy                                = "default"
  hibernation                            = false
  metadata_http_endpoint                 = "enabled"
  metadata_http_tokens                   = "optional"
  metadata_http_put_response_hop_limit   = 1
  metadata_instance_metadata_tags        = "disabled"
  enclave_enabled                        = false
  root_volume_type                       = "gp2"
  root_volume_size                       = 8
  root_delete_on_termination             = true
}