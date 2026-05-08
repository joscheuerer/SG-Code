# neha-private-runner-infrastructure

## Description

EC2 instances (private runner ASG node and community01), IAM instance profile, key pair, and network interface for the Neha Private Runner setup in eu-central-1.

## Architecture Overview

This stack provisions the following resources in `eu-central-1`:

- **IAM Instance Profile** – `Neha_Private_Runner-runner-instance-profile` backed by the `Neha_Private_Runner-ec2-private-runner-role` IAM role.
- **EC2 Key Pair** – `adis-key-pair` used by the private runner ASG instance.
- **EC2 Instances** (managed via `for_each`):
  - `neha_private_runner_private_runner_asg` – `t3.medium` in `eu-central-1a`, part of the private runner ASG.
  - `community01` – `t2.small` in `eu-central-1a`, standalone community instance.
- **Network Interface** – Primary ENI (`eni-04f85c5758d32f536`) with private IP `10.0.0.212` in subnet `subnet-0b77c0d76befaf70d`.

## Module Overview

| Module | Source | Description |
|--------|--------|-------------|
| `iam_instance_profile` | `./modules/iam_instance_profile` | IAM instance profile for private runner EC2 instances |
| `key_pair` | `./modules/key_pair` | EC2 key pair used by instances |
| `instance` | `./modules/instance` | Manages EC2 instances (for_each over `var.instances`) |
| `network_interface` | `./modules/network_interface` | Primary network interface for the private runner EC2 instance |

## Variables Reference

| Name | Type | Description |
|------|------|-------------|
| `region` | `string` | AWS region |
| `instance_profile_name` | `string` | Name of the IAM instance profile |
| `instance_profile_path` | `string` | Path to the IAM instance profile |
| `instance_profile_role` | `string` | Name of the IAM role to associate with the instance profile |
| `key_pair_key_name` | `string` | Name of the EC2 key pair |
| `key_pair_public_key` | `string` (sensitive) | Public key material for the EC2 key pair |
| `instances` | `map(object(...))` | Map of EC2 instance configurations |
| `eni_subnet_id` | `string` | Subnet ID for the primary network interface |
| `eni_private_ips` | `list(string)` | List of private IPs to assign to the ENI |
| `eni_security_groups` | `list(string)` | List of security group IDs to assign to the ENI |
| `eni_source_dest_check` | `bool` | Whether to enable source/destination checking on the ENI |

## Outputs Reference

| Name | Description |
|------|-------------|
| `instance_profile_arn` | ARN of the IAM instance profile |
| `key_pair_key_name` | Name of the EC2 key pair |
| `network_interface_id` | ID of the primary network interface |

## Usage Instructions

### 1. Initialize

```sh
terraform init
```

### 2. Import existing resources

```sh
./imports.sh terraform
# or with OpenTofu:
./imports.sh tofu
```

### 3. Plan

```sh
terraform plan -var-file environments/sg.tfvars
```

### 4. Apply

```sh
terraform apply -var-file environments/sg.tfvars
```

## Notes

- The `key_pair_public_key` variable is sensitive. After import, Terraform will attempt to detect drift on the public key. Since the AWS API does not return the public key, set this variable to the actual public key value to avoid unintended replacement.
- Tags prefixed with `aws:` (e.g., `aws:autoscaling:groupName`) are managed by AWS and are included in the configuration to prevent drift. Do not remove them.
- The `root_block_device_iops` for `gp2` volumes is informational; AWS manages IOPS automatically for `gp2`. Setting it to `0` or `100` in the config matches the discovered state.