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

security_group_name        = "packer_68c879f3-344d-174a-2c11-4dcb15c975ed"
security_group_description = "Temporary group for Packer"
security_group_ingress = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["178.77.15.22/32"]
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

ebs_availability_zone    = "eu-central-1a"
ebs_size                 = 8
ebs_type                 = "gp2"
ebs_iops                 = 100
ebs_encrypted            = false
ebs_multi_attach_enabled = false
ebs_snapshot_id          = "snap-0baba8406ae0d8928"

instance_ami                                     = "ami-0242293c1166ee926"
instance_instance_type                           = "t3.medium"
instance_key_name                                = "packer_68c879f2-1468-642a-6776-a06c2a3c37fc"
instance_availability_zone                       = "eu-central-1a"
instance_tenancy                                 = "default"
instance_ebs_optimized                           = false
instance_source_dest_check                       = true
instance_monitoring                              = false
instance_capacity_reservation_preference         = "none"
instance_cpu_core_count                          = 1
instance_cpu_threads_per_core                    = 2
instance_enclave_options_enabled                 = false
instance_metadata_http_endpoint                  = "enabled"
instance_metadata_http_protocol_ipv6             = "disabled"
instance_metadata_http_put_response_hop_limit    = 1
instance_metadata_http_tokens                    = "optional"
instance_metadata_instance_metadata_tags         = "disabled"
instance_root_block_device_delete_on_termination = true

eni_private_ips      = ["10.0.0.172"]
eni_source_dest_check = true
eni_device_index     = 0