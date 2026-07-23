region = "eu-central-1"

vpc_name             = "private-runner-vpc"
vpc_cidr             = "10.0.0.0/16"
vpc_instance_tenancy = "default"
azs                  = ["eu-central-1a"]
public_subnets       = ["10.0.0.0/20"]
private_subnets      = ["10.0.128.0/20"]
map_public_ip_on_launch       = false
create_igw                    = true
create_vpc                    = true
create_egress_only_igw        = false
manage_default_security_group = true
manage_default_network_acl    = false
manage_default_route_table    = true

cdk_assets_bucket_name             = "cdk-hnb659fds-assets-470037505301-us-east-1"
cdk_assets_block_public_acls       = true
cdk_assets_block_public_policy     = true
cdk_assets_ignore_public_acls      = true
cdk_assets_restrict_public_buckets = true
cdk_assets_versioning = {
  enabled    = "true"
  mfa_delete = "false"
}
cdk_assets_server_side_encryption_configuration = {
  rule = {
    apply_server_side_encryption_by_default = {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = false
  }
}
cdk_assets_lifecycle_rule = [
  {
    id      = "CleanupOldVersions"
    enabled = true
    noncurrent_version_expiration = {
      days = 30
    }
  },
  {
    id      = "AbortIncompleteMultipartUploads"
    enabled = true
    abort_incomplete_multipart_upload_days = 1
  }
]
cdk_assets_control_object_ownership = true
cdk_assets_object_ownership         = "BucketOwnerEnforced"
cdk_assets_tags = {
  "aws:cloudformation:stack-name"  = "CDKToolkit"
  "aws:cloudformation:logical-id"  = "StagingBucket"
  "aws:cloudformation:stack-id"    = "arn:aws:cloudformation:us-east-1:470037505301:stack/CDKToolkit/f2e9ee10-ba81-11f0-bad4-0afff015b437"
}

private_runner_storage_bucket_name             = "p0w7vdek-private-runner-storage-backend"
private_runner_storage_block_public_acls       = true
private_runner_storage_block_public_policy     = true
private_runner_storage_ignore_public_acls      = true
private_runner_storage_restrict_public_buckets = true
private_runner_storage_server_side_encryption_configuration = {
  rule = {
    apply_server_side_encryption_by_default = {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}
private_runner_storage_control_object_ownership = true
private_runner_storage_object_ownership         = "BucketOwnerEnforced"

instance_ami                                  = "ami-04f9a173520f395dd"
instance_type                                 = "t2.large"
instance_subnet_id                            = "subnet-064f42dced8666a63"
instance_key_name                             = "private-runner-workshop"
instance_iam_instance_profile                 = "ec2_private_runner_role"
instance_source_dest_check                    = true
instance_vpc_security_group_ids               = ["sg-0adb3e09fe11a19a1"]
instance_availability_zone                    = "eu-central-1a"
instance_ebs_optimized                        = false
instance_monitoring                           = false
instance_tenancy                              = "default"
instance_metadata_http_endpoint               = "enabled"
instance_metadata_http_protocol_ipv6          = "disabled"
instance_metadata_http_put_response_hop_limit = 2
instance_metadata_http_tokens                 = "required"
instance_metadata_instance_metadata_tags      = "disabled"
instance_tags = {
  App  = "Sun"
  Name = "private-runner-do-not-delete"
}

eni_subnet_id         = "subnet-064f42dced8666a63"
eni_private_ips       = ["10.0.13.161"]
eni_security_groups   = ["sg-0adb3e09fe11a19a1"]
eni_source_dest_check = true

sg_vpc_id = "vpc-00784ac9c64d4472b"

sg_launch_wizard_name        = "launch-wizard"
sg_launch_wizard_description = "launch-wizard created 2024-03-14T19:30:30.394Z"

sg_default_name        = "default"
sg_default_description = "default VPC security group"

sg_launch_wizard_1_name        = "launch-wizard-1"
sg_launch_wizard_1_description = "launch-wizard-1 created 2024-03-15T06:48:45.634Z"

nacl_vpc_id    = "vpc-00784ac9c64d4472b"
nacl_subnet_ids = ["subnet-064f42dced8666a63", "subnet-070f56eea88d75567"]