# EC2 Instances Stack

## Overview

This Terraform stack manages EC2 instances with their network interfaces and block devices in the `eu-central-1` region. It provides a flexible module-based approach for creating and managing EC2 instances with additional EBS volumes.

## Architecture

The stack consists of a single module:

### Module: instance

Manages EC2 instances with their network interfaces and block devices. Supports:
- EC2 instance creation with full configuration control
- Additional EBS volume provisioning
- Volume attachment to instances
- Comprehensive metadata and capacity reservation options

## Resources

| Resource Type | Count | Description |
|--------------|-------|-------------|
| `aws_instance` | 2 | EC2 instances with full configuration |
| `aws_ebs_volume` | 1 | Additional EBS volumes |
| `aws_volume_attachment` | 1 | Volume attachments to instances |

## Variables

### Root Variables

| Name | Type | Description | Required |
|------|------|-------------|----------|
| `region` | string | AWS region for resources | Yes |
| `instances` | map(object) | Map of EC2 instances to create | Yes |
| `additional_ebs_volumes` | map(object) | Additional EBS volumes to attach to instances | Yes |

### Instance Object Structure

Each instance in the `instances` map requires:
- `ami_id`: AMI ID for the instance
- `instance_type`: EC2 instance type
- `availability_zone`: Availability zone
- `key_name`: SSH key pair name
- `iam_instance_profile_arn`: IAM instance profile ARN (optional)
- `subnet_id`: VPC subnet ID
- `security_group_ids`: List of security group IDs
- `associate_public_ip_address`: Whether to associate a public IP
- `source_dest_check`: Enable source/destination checking
- `ebs_optimized`: Enable EBS optimization
- `monitoring`: Enable detailed monitoring
- `tenancy`: Instance tenancy (default, dedicated, host)
- `hibernation`: Enable hibernation
- `cpu_core_count`: Number of CPU cores
- `cpu_threads_per_core`: Threads per CPU core
- `metadata_options`: Instance metadata service configuration
- `capacity_reservation_specification`: Capacity reservation preferences
- `enclave_options`: Nitro Enclaves configuration
- `root_block_device`: Root volume configuration
- `tags`: Resource tags

### EBS Volume Object Structure

Each volume in the `additional_ebs_volumes` map requires:
- `instance_key`: Key of the instance to attach to
- `device_name`: Device name for attachment
- `availability_zone`: Availability zone
- `size`: Volume size in GB
- `type`: Volume type (gp2, gp3, io1, etc.)
- `encrypted`: Enable encryption
- `force_detach`: Force detachment on destroy
- `tags`: Resource tags

## Outputs

| Name | Description |
|------|-------------|
| `instance_ids` | Map of instance keys to instance IDs |
| `private_ips` | Map of instance keys to private IP addresses |
| `public_ips` | Map of instance keys to public IP addresses |

## Usage

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Import Existing Resources

```bash
chmod +x imports.sh
./imports.sh
```

### 3. Review Changes

```bash
terraform plan -var-file=environments/terraform.tfvars
```

### 4. Apply Configuration

```bash
terraform apply -var-file=environments/terraform.tfvars
```

## Current Configuration

The stack currently manages:

1. **Instance: i_000e597ea8aa8260b**
   - Type: t2.medium
   - AMI: ami-03074cc1b166e8691
   - Zone: eu-central-1a
   - Private networking (no public IP)
   - IMDSv2 required

2. **Instance: sg_runner_new_private_runner_asg**
   - Type: t3.medium
   - AMI: ami-0c954b75beb1d9bc1
   - Zone: eu-central-1a
   - Public networking enabled
   - IAM instance profile attached
   - Auto Scaling Group member
   - Additional 8GB gp2 EBS volume attached

## Security Considerations

- All instances use IMDSv2 (http_tokens = "required") for enhanced security
- Instance metadata tags are disabled
- Source/destination checking is enabled on all instances
- EBS volumes can be configured with encryption as needed

## Notes

- This configuration imports existing AWS resources
- The stack is designed for zero-drift operation
- All sensitive values should be managed through secure variable mechanisms
- Review security group rules and IAM policies separately