region = "eu-central-1"

vpc_cidr_block       = "10.0.0.0/16"
vpc_instance_tenancy = "default"
vpc_tags = {
  Name = "vpc_name"
}

subnet_cidr_block                      = "10.0.0.0/24"
subnet_availability_zone               = "eu-central-1a"
subnet_map_public_ip_on_launch         = true
subnet_assign_ipv6_address_on_creation = false
subnet_tags = {
  Name = "vpc_name-public-eu-central-1a"
}

security_group_name        = "ec2-sg-09a43dgt"
security_group_description = "Security group for EC2 instance - SSH access"
security_group_ingress = [
  {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "SSH"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
]
security_group_egress = [
  {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "All outbound traffic"
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
]

ebs_availability_zone    = "eu-central-1a"
ebs_size                 = 20
ebs_type                 = "gp3"
ebs_iops                 = 3000
ebs_throughput           = 125
ebs_encrypted            = false
ebs_multi_attach_enabled = false
ebs_snapshot_id          = "snap-0b0311f5a7890791a"

eni_private_ips       = ["10.0.0.65"]
eni_source_dest_check = true
eni_device_index      = 0

instance_ami                                     = "ami-03b7a7ce915b46b75"
instance_instance_type                           = "t3.medium"
instance_key_name                                = "ec2-key-09a43dgt"
instance_availability_zone                       = "eu-central-1a"
instance_tenancy                                 = "default"
instance_source_dest_check                       = true
instance_ebs_optimized                           = false
instance_monitoring                              = false
instance_metadata_http_endpoint                  = "enabled"
instance_metadata_http_protocol_ipv6             = "disabled"
instance_metadata_http_put_response_hop_limit    = 1
instance_metadata_http_tokens                    = "optional"
instance_metadata_instance_metadata_tags         = "disabled"
instance_capacity_reservation_preference         = "open"
instance_enclave_options_enabled                 = false
instance_root_block_device_delete_on_termination = true