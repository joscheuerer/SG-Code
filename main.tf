module "ebs_volumes" {
  source = "./modules/ebs_volume"

  volumes = var.volumes
}