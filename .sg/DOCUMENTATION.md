# EC2 Instance Infrastructure

## Overview

This Terraform stack manages an EC2 instance with security group and network interface in the eu-central-1 region. The infrastructure includes a t3.micro instance with SSH access configured through a security group.

## Modules

### instance

Manages EC2 instance with root EBS volume. Configures compute resources, networking, metadata options, and storage settings.

**Resources:**
- `aws_instance.this` - EC2 instance with customizable compute and storage configuration

### security_group

Manages security group for EC2 instance. Provides network access control with configurable ingress and egress rules.

**Resources:**
- `aws_security_group.this` - Security group for the instance
- `aws_security_group_rule.this` - Ingress rules (for_each)
- `aws_security_group_rule.egress` - Egress rules (for_each)

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | "eu-central-1" |
| vpc_id | string | VPC ID | "vpc-024344e8549773d40" |
| subnet_id | string | Subnet ID | "subnet-0b77c0d76befaf70d" |
| security_group_ingress_rules | map(object) | Security group ingress rules | SSH on port 22 |
| security_group_egress_rules | map(object) | Security group egress rules | All outbound traffic |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | EC2 instance ID |
| instance_private_ip | Private IP address of the instance |
| instance_public_ip | Public IP address of the instance |
| security_group_id | Security group ID |

## Usage

### Initialize Terraform

```bash
terraform init
```

### Import Existing Resources

```bash
chmod +x imports.sh
./imports.sh
```

### Plan Changes

```bash
terraform plan -var-file=environments/terraform.tfvars
```

### Apply Configuration

```bash
terraform apply -var-file=environments/terraform.tfvars
```

## Resource Configuration

### EC2 Instance

- **AMI:** ami-074dd8e8dac7651a5
- **Instance Type:** t3.micro
- **Availability Zone:** eu-central-1a
- **Key Pair:** ec2-key-thz89qha
- **Root Volume:** 20GB gp3 with 3000 IOPS and 125 MB/s throughput

### Security Group

- **Name:** ec2-sg-thz89qha
- **Ingress:** SSH (port 22) from 0.0.0.0/0
- **Egress:** All traffic to 0.0.0.0/0

## Notes

- This configuration imports existing cloud resources
- The goal is zero drift - `terraform plan` should show no changes after import
- All security settings match the existing infrastructure
- Root volume is unencrypted as per existing configuration