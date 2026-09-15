# Environment-specific variable values for this stack.

instances = {
  taher_private_runner_ubuntu = {
    ami                    = "ami-03250b0e01c28d196"
    instance_type          = "t2.medium"
    key_name               = "taher-private-runner"
    subnet_id              = "subnet-072669658da496c4a"
    vpc_security_group_ids = ["sg-092a5ff991a0802bc"]
    source_dest_check      = false
    tenancy                = "default"
    ebs_optimized          = false
    metadata_options = {
      http_endpoint               = "enabled"
      http_tokens                 = "required"
      http_put_response_hop_limit = 2
      instance_metadata_tags      = "disabled"
    }
    root_block_device = {
      volume_type           = "gp3"
      volume_size           = 6400
      delete_on_termination = false
      encrypted             = false
    }
    tags = {
      Name = "taher-private-runner-ubuntu-new"
    }
  }
}

ebs_volumes = {
  vol_072212cd519ee269f = {
    availability_zone    = "eu-central-1b"
    size                 = 32
    type                 = "gp3"
    iops                 = 4044
    throughput           = 125
    encrypted            = false
    multi_attach_enabled = false
  }
}

key_pairs = {
  taher_private_runner = {
    key_name = "taher-private-runner"
  }
}