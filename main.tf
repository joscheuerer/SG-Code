module "ebs_volumes" {bcvb
  source = "./modules/ebs_volume"

  volumes = var.volumes
}