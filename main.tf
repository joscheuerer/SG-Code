module "vpc_name" {
  source = "./modules/vpc"

  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "vpc_name"
  }
}

module "vpc_name_public_subnet" {
  source = "./modules/subnet"

  vpc_id                          = module.vpc_name.id
  cidr_block                      = "10.0.0.0/24"
  availability_zone               = "eu-central-1a"
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = false
  tags = {
    Name = "vpc_name-public-eu-central-1a"
  }
}

module "sg_runner_new_security_group" {
  source = "./modules/security_group"

  name        = "SG_RUNNER_new-private-runner"
  description = "Block inboud and Allow All outbound for Private Runner."
  vpc_id      = module.vpc_name.id
  rules = {
    ssh_ingress = {
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["115.96.62.109/32"]
      description = "SSH"
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

module "clara_key_pair" {
  source = "./modules/key_pair"

  key_name   = "clara-sg-privaterunner"
  public_key = var.clara_sg_privaterunner_public_key
}

module "sg_runner_instance_profile" {
  source = "./modules/iam_instance_profile"

  profile_name = "SG_RUNNER_new-runner-instance-profile"
  path         = "/"
  role_name    = var.sg_runner_role_name
}

module "eni_02b2519b0f908256d" {
  source = "./modules/network_interface"

  subnet_id         = module.vpc_name_public_subnet.id
  private_ips       = ["10.0.0.237"]
  security_groups   = [module.sg_runner_new_security_group.id]
  source_dest_check = true
}

module "instances" {
  source = "./modules/instance"

  instances = {
    i_000e597ea8aa8260b = {
      ami_id                          = "ami-03074cc1b166e8691"
      instance_type                   = "t2.medium"
      availability_zone               = "eu-central-1a"
      key_name                        = var.taher_private_runner_key_name
      iam_instance_profile_arn        = null
      subnet_id                       = var.subnet_072669658da496c4a_id
      security_group_ids              = [var.sg_0d5bf7aeaa53bfb92_id]
      associate_public_ip_address     = false
      source_dest_check               = true
      ebs_optimized                   = false
      monitoring_enabled              = false
      tenancy                         = "default"
      cpu_core_count                  = 2
      cpu_threads_per_core            = 1
      root_volume_type                = "gp2"
      root_volume_size                = 8
      root_delete_on_termination      = true
      metadata_http_endpoint          = "enabled"
      metadata_http_tokens            = "required"
      metadata_hop_limit              = 2
      metadata_http_protocol_ipv6     = "disabled"
      metadata_instance_tags          = "disabled"
      enclave_enabled                 = false
      capacity_reservation_preference = "open"
      tags                            = {}
    }
    sg_runner_new_private_runner_asg = {
      ami_id                          = "ami-0c954b75beb1d9bc1"
      instance_type                   = "t3.medium"
      availability_zone               = "eu-central-1a"
      key_name                        = module.clara_key_pair.key_name
      iam_instance_profile_arn        = module.sg_runner_instance_profile.arn
      subnet_id                       = module.vpc_name_public_subnet.id
      security_group_ids              = [module.sg_runner_new_security_group.id]
      associate_public_ip_address     = true
      source_dest_check               = true
      ebs_optimized                   = false
      monitoring_enabled              = false
      tenancy                         = "default"
      cpu_core_count                  = 1
      cpu_threads_per_core            = 2
      root_volume_type                = "gp2"
      root_volume_size                = 50
      root_delete_on_termination      = true
      metadata_http_endpoint          = "enabled"
      metadata_http_tokens            = "required"
      metadata_hop_limit              = 2
      metadata_http_protocol_ipv6     = "disabled"
      metadata_instance_tags          = "disabled"
      enclave_enabled                 = false
      capacity_reservation_preference = "open"
      tags = {
        Name                          = "SG_RUNNER_new-private-runner-asg"
        "aws:autoscaling:groupName"   = "SG_RUNNER_new-private-runner-asg"
        "aws:ec2launchtemplate:version" = "1"
        "aws:ec2launchtemplate:id"    = "lt-0214ccad66ff870eb"
      }
    }
    i_007e6212f82fd1d38 = {
      ami_id                          = "ami-0242293c1166ee926"
      instance_type                   = "t3.medium"
      availability_zone               = "eu-central-1a"
      key_name                        = var.packer_key_name
      iam_instance_profile_arn        = null
      subnet_id                       = module.vpc_name_public_subnet.id
      security_group_ids              = [var.sg_04211bd5ce13e32c0_id]
      associate_public_ip_address     = false
      source_dest_check               = true
      ebs_optimized                   = false
      monitoring_enabled              = false
      tenancy                         = "default"
      cpu_core_count                  = 1
      cpu_threads_per_core            = 2
      root_volume_type                = "gp2"
      root_volume_size                = 8
      root_delete_on_termination      = true
      metadata_http_endpoint          = "enabled"
      metadata_http_tokens            = "optional"
      metadata_hop_limit              = 1
      metadata_http_protocol_ipv6     = "disabled"
      metadata_instance_tags          = "disabled"
      enclave_enabled                 = false
      capacity_reservation_preference = "none"
      tags                            = {}
    }
    ecs_instances_admin_workflow_qa = {
      ami_id                          = "ami-0f37a3fdaaaf3661e"
      instance_type                   = "t2.medium"
      availability_zone               = "eu-central-1a"
      key_name                        = var.nonprod_euc1_key_name
      iam_instance_profile_arn        = var.amazonec2containerserviceforec2role_arn
      subnet_id                       = var.subnet_072669658da496c4a_id
      security_group_ids              = [var.sg_064cbb231ba1bca24_id]
      associate_public_ip_address     = false
      source_dest_check               = true
      ebs_optimized                   = false
      monitoring_enabled              = false
      tenancy                         = "default"
      cpu_core_count                  = 2
      cpu_threads_per_core            = 1
      root_volume_type                = "gp2"
      root_volume_size                = 8
      root_delete_on_termination      = true
      metadata_http_endpoint          = "enabled"
      metadata_http_tokens            = "optional"
      metadata_hop_limit              = 1
      metadata_http_protocol_ipv6     = "disabled"
      metadata_instance_tags          = "disabled"
      enclave_enabled                 = false
      capacity_reservation_preference = "open"
      tags = {
        Name                          = "ecs-instances-admin-workflow-qa"
        "aws:autoscaling:groupName"   = "ecs-instances-admin-workflow-qa"
        Resource-Type                 = "nonprod"
        "aws:ec2launchtemplate:version" = "10"
        "aws:ec2launchtemplate:id"    = "lt-0f212ff506c4e1680"
      }
    }
  }

  ebs_volumes = {
    vol_0f5a54343d85c2ca9 = {
      availability_zone    = "eu-central-1a"
      size                 = 100
      volume_type          = "gp3"
      iops                 = 3000
      throughput           = 125
      encrypted            = false
      snapshot_id          = null
      multi_attach_enabled = false
    }
  }

  volume_attachments = {
    vol_0f5a54343d85c2ca9_attachment = {
      device_name                    = "/dev/sda1"
      volume_id                      = var.vol_0f5a54343d85c2ca9_id
      instance_id                    = var.i_0073fcf5e556169e8_id
      stop_instance_before_detaching = false
    }
  }
}