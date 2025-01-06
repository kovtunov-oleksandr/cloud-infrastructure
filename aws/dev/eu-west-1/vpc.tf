module "vpc" {
  source = "../../../modules/vpc"

  environment = local.environment
  region = local.region

  vpc = {
    cidr_block           = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
  }

  subnets = {
    private = [
      {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "eu-west-1a"
      }
    ]
    public = [
      {
        cidr_block        = "10.0.101.0/24"
        availability_zone = "eu-west-1a"
      }
    ]
  }

  tags = local.tags
}
