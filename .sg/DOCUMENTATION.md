# EC2 Instance Infrastructure

## Overview

This Terraform stack manages a complete EC2 instance infrastructure including VPC, subnet, security group, EBS volume, and EC2 instance configuration in the eu-central-1 region.

## Architecture

The stack consists of five modules:

1. **VPC Module** - Creates a Virtual Private Cloud with configurable CIDR block and tenancy
2. **Subnet Module** - Provisions a subnet within the VPC with public IP assignment capability
3. **Security Group Module** - Manages security group with configurable ingress and egress rules
4. **EBS Volume Module** - Creates an EBS volume with specified size, type, and performance characteristics
5. **Instance Module** - Deploys an EC2 instance with comprehensive configuration options

## Module Details

### VPC Module (`modules/vpc`)

Creates a VPC with the following configuration:
- CIDR block: 10.0.0.0/16
- Instance tenancy: default
- Custom tags

**Outputs:**
- `vpc_id` - The VPC identifier
- `owner_id` - The VPC owner account ID

### Subnet Module (`modules/subnet`)

Creates a subnet within the VPC:
- CIDR block: 10.0.0.0/24
- Availability zone: eu-central-1a
- Auto-assigns public IPs on launch

**Outputs:**
- `subnet_id` - The subnet identifier

### Security Group Module (`modules/security_group`)

Manages security group with dynamic rule creation:
- Name: ec2-sg-3hgs1rry
- Supports multiple ingress and egress rules via maps
- Default configuration includes SSH access (port 22) and all outbound traffic

**Outputs:**
- `security_group_id` - The security group identifier

### EBS Volume Module (`modules/ebs_volume`)

Creates an EBS volume with:
- Size: 20 GiB
- Type: gp3
- IOPS: 3000
- Throughput: 125 MB/s
- Created from snapshot: snap-06fcd4dec42bceeff

**Outputs:**
- `volume_id` - The EBS volume identifier

### Instance Module (`modules/instance`)

Deploys an EC2 instance with comprehensive configuration:
- AMI: ami-074dd8e8dac7651a5
- Instance type: t3.medium
- Key pair: ec2-key-3hgs1rry
- CPU configuration: 1 core, 2 threads per core
- Root volume: 20 GiB gp3 with 3000 IOPS and 125 MB/s throughput
- Metadata service: enabled with optional IMDSv2
- Capacity reservation: open

**Outputs:**
- `instance_id` - The EC2 instance identifier
- `private_ip` - Private IP address
- `public_ip` - Public IP address

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | eu-central-1 |
| ingress_rules | map(object) | Security group ingress rules | SSH from 0.0.0.0/0 |
| egress_rules | map(object) | Security group egress rules | All traffic to 0.0.0.0/0 |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC identifier |
| subnet_id | Subnet identifier |
| security_group_id | Security group identifier |
| instance_id | EC2 instance identifier |
| instance_public_ip | Public IP address of the instance |
| instance_private_ip | Private IP address of the instance |
| ebs_volume_id | EBS volume identifier |

## Usage

### Initialize Terraform

```bash
terraform init
```

### Import Existing Resources

Before applying changes, import the existing infrastructure:

```bash
chmod +x imports.sh
./imports.sh
```

### Plan Changes

Review the planned changes:

```bash
terraform plan -var-file=environments/terraform.tfvars
```

### Apply Configuration

Apply the configuration to match the imported state:

```bash
terraform apply -var-file=environments/terraform.tfvars
```

## Security Considerations

- The security group allows SSH access from any IP (0.0.0.0/0). Consider restricting this to specific IP ranges in production.
- The EBS volume is not encrypted. Enable encryption for sensitive data.
- The instance uses IMDSv2 in optional mode. Consider requiring IMDSv2 for enhanced security.
- Root volume is configured to delete on termination. Adjust this setting based on data retention requirements.

## Notes

- This configuration imports existing AWS resources. The initial `terraform plan` after import should show zero changes.
- The EBS volume is created from a snapshot but is not automatically attached to the instance. Use `aws_volume_attachment` resource if attachment is required.
- All hardcoded values (AMI IDs, snapshot IDs, key names) are environment-specific and should be updated for different deployments.