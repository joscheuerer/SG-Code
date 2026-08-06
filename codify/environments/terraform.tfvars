region = "eu-central-1"

instances = {
  i_000e597ea8aa8260b = {
    ami_id                      = "ami-03074cc1b166e8691"
    instance_type               = "t2.medium"
    availability_zone           = "eu-central-1a"
    key_name                    = "taher-private-runner"
    iam_instance_profile_arn    = null
    subnet_id                   = "subnet-072669658da496c4a"
    security_group_ids          = ["sg-0d5bf7aeaa53bfb92"]
    associate_public_ip_address = false
    source_dest_check           = true
    ebs_optimized               = false
    monitoring                  = false
    tenancy                     = "default"
    hibernation                 = false
    cpu_core_count              = 2
    cpu_threads_per_core        = 1
    metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 2
      http_protocol_ipv6          = "disabled"
      instance_metadata_tags      = "disabled"
    }
    capacity_reservation_specification = {
      capacity_reservation_preference = "open"
    }
    enclave_options = {
      enabled = false
    }
    root_block_device = {
      volume_type           = "gp2"
      delete_on_termination = true
    }
    tags = {}
  }
  sg_runner_new_private_runner_asg = {
    ami_id                      = "ami-0c954b75beb1d9bc1"
    instance_type               = "t3.medium"
    availability_zone           = "eu-central-1a"
    key_name                    = "clara-sg-privaterunner"
    iam_instance_profile_arn    = "arn:aws:iam::790543352839:instance-profile/SG_RUNNER_new-runner-instance-profile"
    subnet_id                   = "subnet-0b77c0d76befaf70d"
    security_group_ids          = ["sg-0d2894f23f4b8f7e7"]
    associate_public_ip_address = true
    source_dest_check           = true
    ebs_optimized               = false
    monitoring                  = false
    tenancy                     = "default"
    hibernation                 = false
    cpu_core_count              = 1
    cpu_threads_per_core        = 2
    metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 2
      http_protocol_ipv6          = "disabled"
      instance_metadata_tags      = "disabled"
    }
    capacity_reservation_specification = {
      capacity_reservation_preference = "open"
    }
    enclave_options = {
      enabled = false
    }
    root_block_device = {
      volume_type           = "gp2"
      delete_on_termination = true
    }
    tags = {
      "aws:autoscaling:groupName"     = "SG_RUNNER_new-private-runner-asg"
      "aws:ec2launchtemplate:version" = "1"
      "aws:ec2launchtemplate:id"      = "lt-0214ccad66ff870eb"
      "Name"                          = "SG_RUNNER_new-private-runner-asg"
    }
  }
}

additional_ebs_volumes = {
  sg_runner_sda1 = {
    instance_key      = "sg_runner_new_private_runner_asg"
    device_name       = "/dev/sda1"
    availability_zone = "eu-central-1a"
    size              = 8
    type              = "gp2"
    encrypted         = false
    force_detach      = false
    tags              = {}
  }
}