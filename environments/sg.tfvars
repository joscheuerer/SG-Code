region = "eu-central-1"

iam_instance_profile_name = "ec2_private_runner_role"
iam_instance_profile_path = "/"
iam_instance_profile_role = "ec2_private_runner_role"

key_pair_key_name   = "private-runner-workshop"
key_pair_public_key = ""

instance_ami                                     = "ami-04f9a173520f395dd"
instance_instance_type                           = "t2.large"
instance_availability_zone                       = "eu-central-1a"
instance_subnet_id                               = "subnet-064f42dced8666a63"
instance_vpc_security_group_ids                  = ["sg-0adb3e09fe11a19a1"]
instance_source_dest_check                       = true
instance_ebs_optimized                           = false
instance_monitoring                              = false
instance_tenancy                                 = "default"
instance_capacity_reservation_preference         = "open"
instance_cpu_core_count                          = 2
instance_cpu_threads_per_core                    = 1
instance_metadata_http_endpoint                  = "enabled"
instance_metadata_http_protocol_ipv6             = "disabled"
instance_metadata_http_put_response_hop_limit    = 2
instance_metadata_http_tokens                    = "required"
instance_metadata_instance_metadata_tags         = "disabled"
instance_enclave_options_enabled                 = false
instance_root_block_device_delete_on_termination = true
instance_tags = {
  App  = "Sun"
  Name = "private-runner-do-not-delete"
}