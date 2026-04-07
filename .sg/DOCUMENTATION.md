# packer-build-infrastructure

EC2 instance with associated networking and storage resources

## Stack Overview

This Terraform stack provisions a complete EC2 infrastructure including:

- **VPC Module**: Virtual Private Cloud for network isolation
- **Subnet Module**: Public subnet in availability zone
- **Security Group Module**: Security group for controlling network access
- **EBS Volume Module**: EBS volume for instance storage
- **Instance Module**: EC2 instance with attached network interface and storage

## Modules

### vpc
Virtual Private Cloud for network isolation

**Resources:**
- `aws_vpc.this`

### subnet
Public subnet in availability zone

**Resources:**
- `aws_subnet.this`

### security_group
Security group for controlling network access

**Resources:**
- `aws_security_group.this`
- `aws_vpc_security_group_ingress_rule.this` (for_each)
- `aws_vpc_security_group_egress_rule.this` (for_each)

### ebs_volume
EBS volume for instance storage

**Resources:**
- `aws_ebs_volume.this`

### instance
EC2 instance with attached network interface and storage

**Resources:**
- `aws_instance.this`

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| availability_zone | string | Availability zone for resources | - |
| ami_id | string | AMI ID to use for the instance | - |
| instance_type | string | Instance type | - |
| snapshot_id | string | Snapshot ID to create volume from | - |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| subnet_id | Subnet ID |
| security_group_id | Security group ID |
| instance_id | Instance ID |
| instance_private_ip | Instance private IP |
| ebs_volume_id | EBS volume ID |

## Usage

### Initialize

```bash
terraform init
```

### Import Existing Resources

```bash
chmod +x imports.sh
./imports.sh terraform
```

Or for OpenTofu:

```bash
./imports.sh tofu
```

### Plan

```bash
terraform plan -var-file=environments/terraform.tfvars
```

### Apply

```bash
terraform apply -var-file=environments/terraform.tfvars
```

## Region

This stack is configured for region: **eu-central-1**