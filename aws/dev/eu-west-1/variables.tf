locals {
  region = "eu-west-1"
  environment = "dev"
  tags = {
    environment = local.environment
    managed_by  = "terraform"
  }
}
