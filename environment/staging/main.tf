terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Call VPC module
module "vpc" {
  source = "../../modules/vpc"
  # Pass variables as needed 
  vpc_cidr = var.vpc_cidr_block
}

module "security_groups" {
  source = "../../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "../../modules/ec2"
  vpc_id                  = module.vpc.vpc_id
  public_subnet_id        = module.vpc.public_subnet_id
  security_group_id       = module.security_groups.slab_ai_sg_id
}

module "eks" {
  source = "../../modules/eks"
  vpc_id = module.vpc.vpc_id
  private_subnet_id = module.vpc.private_subnet_id
  security_group_id = module.security_groups.eks_sg

}
