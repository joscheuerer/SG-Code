module "ubuntu_debugging" {
  source = "./modules/ec2_instance"

  ami_id                      = "ami-081d42a282b78e6d3"
  instance_type               = "t2.large"
  availability_zone           = "eu-central-1a"
  key_name                    = "nonprod-euc1"
  subnet_id                   = "subnet-072669658da496c4a"
  security_group_ids          = ["sg-064cbb231ba1bca24"]
  source_dest_check           = true
  ebs_optimized               = false
  monitoring                  = false
  hibernation                 = false
  enclave_enabled             = false
  metadata_http_endpoint      = "enabled"
  metadata_http_tokens        = "optional"
  metadata_hop_limit          = 1
  metadata_instance_tags      = "disabled"
  root_volume_type            = "gp3"
  root_volume_size            = 50
  root_volume_iops            = 3000
  root_volume_throughput      = 125
  root_volume_encrypted       = false
  root_delete_on_termination  = true
  snapshot_id                 = "snap-0b90d94f642e04c36"
  multi_attach_enabled        = false
  tags = {
    Name = "ubuntu-liveeo-debugging"
  }
}