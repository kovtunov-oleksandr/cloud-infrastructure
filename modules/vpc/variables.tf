variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc" {
  type = object({
    cidr_block = optional(string)
    enable_dns_hostnames = optional(bool, true)
    enable_dns_support = optional(bool, true)
  })

  validation {
    condition     = can(cidrhost(var.vpc.cidr_block, 0))
    error_message = "VPC CIDR block must be valid IPv4 CIDR."
  }
}

variable "subnets" {
  type = object({
    private = list(object({
      cidr_block = string
      availability_zone = string
    }))
    public = list(object({
      cidr_block = string
      availability_zone = string
      map_public_ip_on_launch = optional(bool, true)
    }))
  })

  validation {
    condition     = length(var.subnets.private) > 0
    error_message = "At least one private subnet must be defined."
  }
}

variable "tags" {
  description = "Tags configuration"
  type = map(string)
  default = {}
}
