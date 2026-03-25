# EC2 Instance with EBS Volume Stack

## Description

This stack manages an EC2 instance with an attached EBS volume in AWS. It imports existing infrastructure resources to bring them under Terraform management with zero drift.

## Stack Overview

- **Name**: ec2-instance-with-ebs
- **Region**: eu-central-1
- **Provider**: AWS (~> 5.0)

## Modules

### ec2_instance

Manages EC2 instance and attached EBS volume.

**Location**: `modules/ec2_instance/`

**Resources**:
- `aws_instance.this` - EC2 instance with configurable compute, networking, and storage settings
- `aws_ebs_volume.this` - EBS volume with configurable size, type, and encryption

## Variables

### Root Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | eu-central-1 |

### Module Variables (ec2_instance)

| Name | Type | Description |
|------|------|-------------|
| ami_id | string | AMI ID for the instance |
| instance_type | string | EC2 instance type |
| availability_zone | string | Availability zone for the instance |
| key_name | string | SSH key pair name |
| subnet_id | string | VPC subnet ID |
| security_group_ids | list(string) | List of security group IDs |
| source_dest_check | bool | Enable source/destination checking |
| ebs_optimized | bool | Enable EBS optimization |
| monitoring | bool | Enable detailed monitoring |
| hibernation | bool | Enable hibernation support |
| enclave_enabled | bool | Enable Nitro Enclaves |
| metadata_http_endpoint | string | Metadata service HTTP endpoint state |
| metadata_http_tokens | string | Metadata service HTTP tokens requirement |
| metadata_hop_limit | number | Metadata service HTTP PUT response hop limit |
| metadata_instance_tags | string | Enable instance tags in metadata |
| root_volume_type | string | Root volume type |
| root_volume_size | number | Root volume size in GB |
| root_volume_iops | number | Root volume IOPS |
| root_volume_throughput | number | Root volume throughput in MB/s |
| root_volume_encrypted | bool | Encrypt root volume |
| root_delete_on_termination | bool | Delete root volume on instance termination |
| snapshot_id | string | Snapshot ID to create volume from |
| multi_attach_enabled | bool | Enable multi-attach for EBS volume |
| tags | map(string) | Resource tags |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | EC2 instance ID |
| instance_private_ip | EC2 instance private IP address |
| volume_id | EBS volume ID |

## Usage

### Prerequisites

- Terraform >= 1.0
- AWS credentials configured
- Existing EC2 instance (i-08f2821d46fa1cbef) and EBS volume (vol-00187254b9eb74e28)

### Deployment Steps

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Import Existing Resources**
   ```bash
   chmod +x imports.sh
   ./imports.sh
   ```

3. **Review Changes**
   ```bash
   terraform plan -var-file=environments/terraform.tfvars
   ```
   
   Expected output: No changes (zero drift after import)

4. **Apply Configuration**
   ```bash
   terraform apply -var-file=environments/terraform.tfvars
   ```

### Managing the Stack

- **View current state**: `terraform show`
- **List resources**: `terraform state list`
- **Update variables**: Edit `environments/terraform.tfvars` and run `terraform apply`
- **Destroy resources**: `terraform destroy -var-file=environments/terraform.tfvars`

## Notes

- This configuration imports existing resources with zero drift
- All values are configured to match the current state of the infrastructure
- The EBS volume is created from snapshot snap-0b90d94f642e04c36
- Instance uses gp3 storage with 3000 IOPS and 125 MB/s throughput