locals {
  region = dirname(abspath(path.module))
  environment = basename(abspath(path.module))
  tags = {
    environment = local.environment
    managed_by  = "terraform"
  }
}
