module "sg" {
  source = "../../../modules/security-group"

  environment = local.environment
  region      = local.region
  tags = local.tags
  vpc_id      = module.vpc.vpc_id
}
