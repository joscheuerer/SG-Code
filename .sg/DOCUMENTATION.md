# EC2 Infrastructure Stack

## Overview

This Terraform stack manages EC2 instances with networking, storage, and IAM configuration in the eu-central-1 region. It imports existing AWS resources to bring them under Terraform management with zero drift.

## Architecture

The stack consists of the following components:

- **VPC**: Virtual Private Cloud with CIDR 10.0.0.0/16
- **Subnet**: Public subnet in eu-central-1a with CIDR 10.0.0.0/24
- **Security Group**: Controls inbound/outbound traffic for EC2 instances
- **Key Pairs**: SSH key pairs for instance access
- **IAM Instance Profile**: Provides IAM role permissions to EC2 instances
- **Network Interface**: Elastic network interface with static private IP
- **EC2 Instances**: Four instances with various configurations
- **EBS Volumes**: Additional storage volumes attached to instances

## Modules

### vpc
Creates a Virtual Private Cloud with configurable CIDR block and instance tenancy.

### subnet
Creates a subnet within a VPC with availability zone and IP assignment settings.

### security_group
Manages security groups and their ingress/egress rules.

### key_pair
Manages EC2 SSH key pairs for instance access.

### iam_instance_profile
Creates IAM instance profiles that attach IAM roles to EC2 instances.

### network_interface
Creates elastic network interfaces with static private IPs.

### instance
Manages EC2 instances with attached EBS volumes and network interfaces. Supports multiple instances via for_each.

## Variables

| Name | Type | Description | Required |
|------|------|-------------|----------|
| region | string | AWS region | Yes |
| clara_sg_privaterunner_public_key | string | Public key material for clara-sg-privaterunner key pair | Yes (sensitive) |
| sg_runner_role_name | string | IAM role name for SG_RUNNER instance profile | Yes |
| taher_private_runner_key_name | string | Key pair name for taher-private-runner | Yes |
| packer_key_name | string | Key pair name for packer | Yes |
| nonprod_euc1_key_name | string | Key pair name for nonprod-euc1 | Yes |
| subnet_072669658da496c4a_id | string | Subnet ID for vpc-0119b9388f2104572 | Yes |
| sg_0d5bf7aeaa53bfb92_id | string | Security group ID for private-runner | Yes |
| sg_04211bd5ce13e32c0_id | string | Security group ID for packer | Yes |
| sg_064cbb231ba1bca24_id | string | Security group ID for default | Yes |
| amazonec2containerserviceforec2role_arn | string | ARN for AmazonEC2ContainerServiceforEC2Role instance profile | Yes |
| vol_0f5a54343d85c2ca9_id | string | Volume ID for additional EBS volume | Yes |
| i_0073fcf5e556169e8_id | string | Instance ID for SG_RUNNER instance | Yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| subnet_id | ID of the subnet |
| security_group_id | ID of the security group |
| instance_ids | Map of instance keys to instance IDs |
| instance_private_ips | Map of instance keys to private IP addresses |
| instance_public_ips | Map of instance keys to public IP addresses |

## Usage

### Prerequisites

1. AWS credentials configured
2. Terraform >= 1.0 installed
3. Existing AWS resources to import

### Deployment Steps

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Update terraform.tfvars**
   
   Edit `environments/terraform.tfvars` and replace placeholder values:
   - `clara_sg_privaterunner_public_key`: Your actual SSH public key
   - `subnet_072669658da496c4a_id`: Actual subnet ID
   - Security group IDs: Actual security group IDs
   - `amazonec2containerserviceforec2role_arn`: Actual instance profile ARN

3. **Import Existing Resources**
   ```bash
   chmod +x imports.sh
   ./imports.sh
   ```

4. **Verify Configuration**
   ```bash
   terraform plan -var-file=environments/terraform.tfvars
   ```
   
   This should show no changes if import was successful.

5. **Apply Changes** (if needed)
   ```bash
   terraform apply -var-file=environments/terraform.tfvars
   ```

## Security Considerations

- Sensitive variables are marked as sensitive in variable definitions
- Public key material is stored securely
- Security group rules follow least-privilege principles
- Instance metadata service configured with IMDSv2 where applicable
- EBS volumes can be encrypted (currently disabled for imported resources)

## Maintenance

- Review security group rules regularly
- Rotate SSH key pairs periodically
- Monitor instance costs and right-size as needed
- Keep AMIs up to date with security patches
- Review IAM instance profile permissions

## Support

For issues or questions, consult the Terraform documentation or your cloud infrastructure team.