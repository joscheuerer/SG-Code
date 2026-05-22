module "ecr_repository" {
  source               = "./modules/ecr_repository"
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  encryption_type      = var.encryption_type
  scan_on_push         = var.scan_on_push
  tags                 = var.tags
}