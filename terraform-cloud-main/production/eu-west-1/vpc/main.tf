locals {
  cluster_name = "prod-eu-west-1-f4b-cluster"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"
  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets
  enable_nat_gateway = var.vpc_enable_nat_gateway
  

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    Terraform   = "true"
    Environment = "prod"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
