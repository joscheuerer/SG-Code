# EBS Volumes Stack

## Overview

This stack manages EBS volumes with varying attachment states and configurations in the eu-central-1 region.

## Architecture

The stack consists of a single module that manages multiple EBS volumes:

- **ebs_volume**: Creates and manages EBS volumes with configurable properties including size, type, encryption, IOPS, throughput, and snapshot source

## Modules

### ebs_volume

Manages EBS volumes with full configuration control.

**Location**: `./modules/ebs_volume`

**Resources**:
- `aws_ebs_volume.this` - EBS volumes (for_each over volumes map)

## Variables

### Root Variables

| Name | Type | Description | Required |
|------|------|-------------|----------|
| region | string | AWS region | Yes |
| volumes | map(object) | EBS volumes to create | Yes |

### Volume Object Structure

Each volume in the `volumes` map requires:

| Field | Type | Description |
|-------|------|-------------|
| availability_zone | string | Availability zone for the volume |
| encrypted | bool | Whether the volume is encrypted |
| iops | number | IOPS for the volume |
| multi_attach_enabled | bool | Whether multi-attach is enabled |
| size | number | Size of the volume in GB |
| snapshot_id | string | Snapshot ID to create volume from |
| throughput | number | Throughput in MB/s |
| volume_type | string | Volume type (gp3, gp2, io1, io2, etc.) |
| tags | map(string) | Tags to apply to the volume (optional) |

## Outputs

| Name | Description |
|------|-------------|
| volume_ids | Map of volume keys to volume IDs |
| volume_arns | Map of volume keys to volume ARNs |

## Usage

### Initial Setup

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Import Existing Resources**:
   ```bash
   chmod +x imports.sh
   ./imports.sh
   ```

3. **Verify Configuration**:
   ```bash
   terraform plan -var-file=environments/terraform.tfvars
   ```
   
   After import, this should show no changes (zero drift).

4. **Apply Configuration** (if needed):
   ```bash
   terraform apply -var-file=environments/terraform.tfvars
   ```

### Managing Volumes

The stack currently manages three EBS volumes:

1. **vol_006016473226c20a1**: 20 GB gp3 volume from snap-06fcd4dec42bceeff
2. **vol_00604ce9672c2753c**: 100 GB gp3 volume from snap-02e8fc76cd2830bdc
3. **vol_007e128ed703166ca**: 30 GB gp3 volume from snap-067d8b07149e12f1a (tagged for sg-external-approval QA environment)

All volumes are:
- Located in eu-central-1a
- Unencrypted
- gp3 type with 3000 IOPS and 125 MB/s throughput
- Multi-attach disabled

### Adding New Volumes

To add a new volume, update `environments/terraform.tfvars`:

```hcl
volumes = {
  # ... existing volumes ...
  vol_new_volume_id = {
    availability_zone    = "eu-central-1a"
    encrypted            = true
    iops                 = 3000
    multi_attach_enabled = false
    size                 = 50
    snapshot_id          = ""
    throughput           = 125
    volume_type          = "gp3"
    tags = {
      Name = "my-new-volume"
    }
  }
}
```

Then run `terraform plan` and `terraform apply`.

## Notes

- All volumes are created from snapshots
- The stack is designed for zero-drift import of existing resources
- Volume keys in the map should match the actual volume IDs for clarity
- Snapshot IDs must exist in the same region before creating volumes