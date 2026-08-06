module "instances" {
  source = "./modules/instance"

  instances              = var.instances
  additional_ebs_volumes = var.additional_ebs_volumes
}