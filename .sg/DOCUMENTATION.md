# EKS EBS CSI Policy Stack

## Description

IAM policy for EKS EBS CSI driver permissions. This stack manages the IAM policy that grants necessary EC2 permissions for the Amazon EBS CSI driver to manage EBS volumes in an EKS cluster.

## Module Overview

### iam_policy

Manages IAM policy for EBS CSI driver. Creates an IAM policy with comprehensive EC2 permissions required for the EBS CSI driver to create, attach, detach, modify, and delete EBS volumes and snapshots.

**Resources:**
- `aws_iam_policy.this` - IAM policy with EBS CSI driver permissions

## Variables

| Name | Type | Description | Default |
|------|------|-------------|---------|
| region | string | AWS region | us-east-1 |

## Outputs

| Name | Description |
|------|-------------|
| ebs_csi_policy_arn | ARN of the EBS CSI driver IAM policy |
| ebs_csi_policy_id | ID of the EBS CSI driver IAM policy |

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

## Policy Permissions

The IAM policy grants the following EC2 permissions:

- **Volume Operations**: Create, attach, detach, modify, delete, and describe EBS volumes
- **Snapshot Operations**: Create, delete, and describe snapshots
- **Tagging**: Create and delete tags on volumes and snapshots
- **Instance Information**: Describe EC2 instances and availability zones
- **Fast Snapshot Restore**: Enable fast snapshot restores

All permissions include appropriate conditions to scope access to resources managed by the EBS CSI driver, identified by specific tags like `ebs.csi.aws.com/cluster`, `CSIVolumeName`, and `kubernetes.io/cluster/*`.