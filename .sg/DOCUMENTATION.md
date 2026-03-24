# EKS Managed Node Infrastructure

## Overview

This Terraform stack manages EKS managed node group infrastructure including networking and compute resources in the `eu-central-1` region. The infrastructure consists of a VPC, subnet, security group, EC2 instance (EKS worker node), and an additional network interface for pod networking.

## Architecture

The stack is organized into five modules:

### 1. VPC Module (`modules/vpc`)
Creates the Virtual Private Cloud that hosts the EKS cluster infrastructure.

**Resources:**
- `aws_vpc.this` - VPC with configurable CIDR block and instance tenancy

### 2. Subnet Module (`modules/subnet`)
Creates a public subnet for EKS worker nodes in availability zone `eu-central-1b`.

**Resources:**
- `aws_subnet.this` - Public subnet with auto-assign public IP enabled

### 3. Security Group Module (`modules/security_group`)
Manages the EKS cluster security group with ingress and egress rules.

**Resources:**
- `aws_security_group.this` - Security group for EKS control plane and managed workloads
- `aws_security_group_rule.this` - Ingress rules (self-referencing for cluster communication)
- `aws_security_group_rule.egress` - Egress rules (allow all outbound traffic)

### 4. Instance Module (`modules/instance`)
Creates the EC2 instance that serves as an EKS managed node.

**Resources:**
- `aws_instance.this` - t3.medium instance with EBS optimization, monitoring, and IMDSv2 enforcement

### 5. Network Interface Module (`modules/network_interface`)
Manages an additional ENI for AWS VPC CNI pod networking.

**Resources:**
- `aws_network_interface.this` - Secondary network interface with multiple private IPs
- `aws_network_interface_attachment.this` - Attachment to the EC2 instance

## Variables

### Root Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| `region` | `string` | AWS region | `"eu-central-1"` |
| `iam_instance_profile_arn` | `string` | IAM instance profile ARN for EC2 instances | `"arn:aws:iam::470037505301:instance-profile/eks-fece5f1f-94cc-37f3-cca2-2de45fbc88e4"` |

## Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | VPC ID |
| `subnet_id` | Subnet ID |
| `security_group_id` | Security group ID |
| `instance_id` | Instance ID |
| `additional_network_interface_id` | Additional network interface ID |

## Usage

### Prerequisites

- Terraform >= 1.0
- AWS provider >= 4.0
- AWS credentials configured
- Existing IAM instance profile: `eks-fece5f1f-94cc-37f3-cca2-2de45fbc88e4`

### Deployment Steps

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Import Existing Resources:**
   ```bash
   chmod +x imports.sh
   ./imports.sh
   ```

3. **Review Changes:**
   ```bash
   terraform plan -var-file=environments/terraform.tfvars
   ```

4. **Apply Configuration:**
   ```bash
   terraform apply -var-file=environments/terraform.tfvars
   ```

### Post-Import Verification

After importing, verify zero drift:
```bash
terraform plan -var-file=environments/terraform.tfvars
```

Expected output: `No changes. Your infrastructure matches the configuration.`

## Resource Tags

All resources are tagged with EKS cluster identification:
- `kubernetes.io/cluster/eks-ms: owned`
- `aws:eks:cluster-name: eks-ms`
- `eks:cluster-name: eks-ms`

The EC2 instance includes additional tags for autoscaling and node group management.

## Security Considerations

- **IMDSv2 Enforcement:** Instance metadata service requires tokens (IMDSv2)
- **Network Isolation:** Security group allows self-referencing traffic only for ingress
- **IAM Roles:** Instance uses a pre-existing IAM instance profile for EKS node permissions
- **Encryption:** Root volume encryption is disabled (matches existing configuration)

## Notes

- This stack imports existing infrastructure; do not modify resource IDs
- The network interface contains 6 private IPs for pod networking via AWS VPC CNI
- Instance monitoring is enabled for CloudWatch detailed metrics
- Root volume is gp3 with 3000 IOPS and 125 MB/s throughput