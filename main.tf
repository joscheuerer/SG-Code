module "security_group" {
  source = "./modules/security_group"

  group_name    = "ec2-sg-thz89qha"
  description   = "Security group for EC2 instance - SSH access"
  vpc_id        = var.vpc_id
  ingress_rules = var.security_group_ingress_rules
  egress_rules  = var.security_group_egress_rules
}

module "instance" {
  source = "./modules/instance"

  ami_id                               = "ami-074dd8e8dac7651a5"
  instance_type                        = "t3.micro"
  availability_zone                    = "eu-central-1a"
  key_name                             = "ec2-key-thz89qha"
  subnet_id                            = var.subnet_id
  vpc_security_group_ids               = [module.security_group.security_group_id]
  source_dest_check                    = true
  ebs_optimized                        = false
  monitoring                           = false
  hibernation                          = false
  enclave_enabled                      = false
  metadata_http_endpoint               = "enabled"
  metadata_http_tokens                 = "optional"
  metadata_http_put_response_hop_limit = 1
  metadata_instance_metadata_tags      = "disabled"
  cpu_core_count                       = 1
  cpu_threads_per_core                 = 2
  root_volume_type                     = "gp3"
  root_volume_size                     = 20
  root_volume_iops                     = 3000
  root_volume_throughput               = 125
  root_volume_encrypted                = false
  root_volume_delete_on_termination    = true
}