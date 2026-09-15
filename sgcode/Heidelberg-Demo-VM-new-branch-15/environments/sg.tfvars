instances = {
  sg_vm_heidelberg_demo = {
    ami                                  = "ami-0e8851af9b98bb0f5"
    instance_type                        = "t3.small"
    availability_zone                    = "eu-central-1a"
    subnet_id                            = "subnet-084f256dab7665e80"
    vpc_security_group_ids               = ["sg-07a25f645d6231e50"]
    key_name                             = "terraform-20260120130007422200000001"
    associate_public_ip_address          = true
    source_dest_check                    = true
    monitoring                           = false
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    hibernation                          = false
    instance_initiated_shutdown_behavior = "stop"
    tenancy                              = "default"
    user_data_replace_on_change          = false
    tags                                 = { Name = "sg-vm-heidelberg-demo" }
    volume_tags                          = { Name = "sg-vm-heidelberg-demo" }
    root_block_device = {
      delete_on_termination = true
      encrypted             = false
      volume_size           = 8
      volume_type           = "gp2"
      iops                  = 100
      throughput            = 0
      kms_key_id            = null
      tags                  = {}
    }
    metadata_options = {
      http_endpoint               = "enabled"
      http_protocol_ipv6          = "disabled"
      http_put_response_hop_limit = 1
      http_tokens                 = "optional"
      instance_metadata_tags      = "disabled"
    }
    credit_specification = {
      cpu_credits = "unlimited"
    }
    cpu_options = {
      core_count       = 1
      threads_per_core = 2
    }
    maintenance_options = {
      auto_recovery = "default"
    }
    private_dns_name_options = {
      enable_resource_name_dns_a_record    = false
      enable_resource_name_dns_aaaa_record = false
      hostname_type                        = "ip-name"
    }
  }
}
