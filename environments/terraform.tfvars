region = "eu-central-1"

volumes = {
  vol_006016473226c20a1 = {
    availability_zone    = "eu-central-1a"
    encrypted            = false
    iops                 = 3000
    multi_attach_enabled = false
    size                 = 20
    snapshot_id          = "snap-06fcd4dec42bceeff"
    throughput           = 125
    volume_type          = "gp3"
    tags                 = {}
  }
  vol_00604ce9672c2753c = {
    availability_zone    = "eu-central-1a"
    encrypted            = false
    iops                 = 3000
    multi_attach_enabled = false
    size                 = 100
    snapshot_id          = "snap-02e8fc76cd2830bdc"
    throughput           = 125
    volume_type          = "gp3"
    tags                 = {}
  }
  vol_007e128ed703166ca = {
    availability_zone    = "eu-central-1a"
    encrypted            = false
    iops                 = 3000
    multi_attach_enabled = false
    size                 = 30
    snapshot_id          = "snap-067d8b07149e12f1a"
    throughput           = 125
    volume_type          = "gp3"
    tags = {
      Project     = "sg-external-approval"
      Environment = "qa"
      ManagedBy   = "terraform"
    }
  }
}