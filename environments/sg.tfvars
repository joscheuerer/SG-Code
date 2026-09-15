instances = {
  test_instance = {
    ami                                  = "ami-0fcc32e5ab94ef9c2"
    instance_type                        = "t2.small"
    subnet_id                            = "subnet-07e07110d14837f7b"
    vpc_security_group_ids               = ["sg-089a4cba2fbf2e7aa"]
    associate_public_ip_address          = true
    availability_zone                    = "eu-central-1a"
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    hibernation                          = false
    instance_initiated_shutdown_behavior = "stop"
    monitoring                           = false
    source_dest_check                    = true
    tenancy                              = "default"
    tags = {
      Name = "test-instance"
    }
    volume_tags = {
      Name = "test-instance"
    }
    root_block_device = [
      {
        delete_on_termination = true
        encrypted             = false
        iops                  = 100
        throughput            = 0
        volume_size           = 8
        volume_type           = "gp2"
        tags                  = {}
      }
    ]
    credit_specification = [
      {
        cpu_credits = "standard"
      }
    ]
    metadata_options = [
      {
        http_endpoint               = "enabled"
        http_protocol_ipv6          = "disabled"
        http_put_response_hop_limit = 1
        http_tokens                 = "optional"
        instance_metadata_tags      = "disabled"
      }
    ]
    private_dns_name_options = [
      {
        enable_resource_name_dns_a_record    = false
        enable_resource_name_dns_aaaa_record = false
        hostname_type                        = "ip-name"
      }
    ]
    maintenance_options = [
      {
        auto_recovery = "default"
      }
    ]
  }
}
