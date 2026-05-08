module "iam_instance_profile" {
  source = "./modules/iam_instance_profile"

  name = var.instance_profile_name
  path = var.instance_profile_path
  role = var.instance_profile_role
}

module "key_pair" {
  source = "./modules/key_pair"

  key_name   = var.key_pair_key_name
  public_key = var.key_pair_public_key
}