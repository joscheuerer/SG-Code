region = "eu-central-1"

instance_profile_name = "Neha_Private_Runner-runner-instance-profile"
instance_profile_path = "/"
instance_profile_role = "Neha_Private_Runner-ec2-private-runner-role"

key_pair_key_name   = "adis-key-pair"
key_pair_public_key = ""

instances = {
  neha_private_runner_private_runner_asg = {
    ami                         = "ami-0a628e1e89aaedf80"
    associate_public_ip_address = false
    availability_zone           = "eu-central-1a"
    ebs_optimized               = false
    iam_instance_profile        = "Neha_Private_Runner-runner-instance-profile"
    instance_type               = "t3.medium"
    key_name                    = "adis-key-pair"
    monitoring                  = false
    source_dest_check           = true
    subnet_id                   = "subnet-0b77c0d76befaf70d"
    tenancy                     = "default"
    vpc_security_group_ids      = []
    tags = {
      "aws:autoscaling:groupName" = "Neha_Private_Runner-runner-asg"
      "Name"                      = "Neha_Private_Runner-runner"
    }
    volume_tags = {}

    capacity_reservation_preference = "open"
    enclave_options_enabled         = false

    metadata_http_endpoint               = "enabled"
    metadata_http_protocol_ipv6          = "disabled"
    metadata_http_put_response_hop_limit = 1
    metadata_http_tokens                 = "optional"
    metadata_instance_metadata_tags      = "disabled"

    root_block_device_delete_on_termination = true
    root_block_device_encrypted             = false
    root_block_device_iops                  = 100
    root_block_device_volume_size           = 8
    root_block_device_volume_type           = "gp2"
  }

  community01 = {
    ami                         = "ami-0a628e1e89aaedf80"
    associate_public_ip_address = false
    availability_zone           = "eu-central-1a"
    ebs_optimized               = false
    iam_instance_profile        = "Neha_Private_Runner-runner-instance-profile"
    instance_type               = "t2.small"
    key_name                    = "adis-key-pair"
    monitoring                  = false
    source_dest_check           = true
    subnet_id                   = "subnet-0b77c0d76befaf70d"
    tenancy                     = "default"
    vpc_security_group_ids      = []
    tags = {
      "Name" = "community01"
    }
    volume_tags = {}

    capacity_reservation_preference = "open"
    enclave_options_enabled         = false

    metadata_http_endpoint               = "enabled"
    metadata_http_protocol_ipv6          = "disabled"
    metadata_http_put_response_hop_limit = 1
    metadata_http_tokens                 = "optional"
    metadata_instance_metadata_tags      = "disabled"

    root_block_device_delete_on_termination = true
    root_block_device_encrypted             = false
    root_block_device_iops                  = 0
    root_block_device_volume_size           = 8
    root_block_device_volume_type           = "gp2"
  }
}

eni_subnet_id         = "subnet-0b77c0d76befaf70d"
eni_private_ips       = ["10.0.0.212"]
eni_security_groups   = []
eni_source_dest_check = true