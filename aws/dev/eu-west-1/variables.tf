locals {
  region = basename(path.cwd)
  environment = basename(abspath(path.module))
  tags = {
    environment = local.environment
    managed_by  = "terraform"
  }
}
