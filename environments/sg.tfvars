region               = "eu-central-1"
vpc_cidr_block       = "10.0.0.0/16"
vpc_instance_tenancy = "default"
vpc_tags = {
  Name = "private-runner-vpc"
}

subnet_cidr_block                      = "10.0.0.0/20"
subnet_availability_zone               = "eu-central-1a"
subnet_assign_ipv6_address_on_creation = false
subnet_map_public_ip_on_launch         = false
subnet_tags = {
  Name = "private-runner-subnet-public1-eu-central-1a"
}

security_group_name        = "launch-wizard-1"
security_group_description = "launch-wizard-1 created 2024-03-15T06:48:45.634Z"
security_group_ingress = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
security_group_egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
security_group_tags = {}

key_pair_key_name   = "private-runner-workshop"
key_pair_public_key = ""

iam_instance_profile_name = "ec2_private_runner_role"
iam_instance_profile_path = "/"
iam_instance_profile_role = "ec2_private_runner_role"

ebs_volume_availability_zone    = "eu-central-1a"
ebs_volume_size                 = 100
ebs_volume_type                 = "gp3"
ebs_volume_iops                 = 3000
ebs_volume_throughput           = 125
ebs_volume_encrypted            = false
ebs_volume_multi_attach_enabled = false
ebs_volume_snapshot_id          = "snap-08c6582254add56c6"
ebs_volume_tags                 = {}

network_interface_private_ips       = ["10.0.13.161"]
network_interface_source_dest_check = true
network_interface_tags              = {}

instance_ami                                     = "ami-04f9a173520f395dd"
instance_instance_type                           = "t2.large"
instance_availability_zone                       = "eu-central-1a"
instance_source_dest_check                       = true
instance_ebs_optimized                           = false
instance_monitoring                              = false
instance_tenancy                                 = "default"
instance_metadata_http_endpoint                  = "enabled"
instance_metadata_http_protocol_ipv6             = "disabled"
instance_metadata_http_put_response_hop_limit    = 2
instance_metadata_http_tokens                    = "required"
instance_metadata_instance_metadata_tags         = "disabled"
instance_enclave_options_enabled                 = false
instance_capacity_reservation_preference         = "open"
instance_root_block_device_delete_on_termination = true
instance_root_block_device_volume_size           = 100
instance_tags = {
  Name = "private-runner-do-not-delete"
  App  = "Sun"
}