terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

module "ecs" {
  source = "./ecs"

  vpc_id                  = module.vpc.vpc_id
  vpc_public_subnets_ids  = module.vpc.public_subnets
  vpc_private_subnets_ids = module.vpc.private_subnets
  aws_region              = var.aws_region
  aws_account_id          = var.aws_account_id
}