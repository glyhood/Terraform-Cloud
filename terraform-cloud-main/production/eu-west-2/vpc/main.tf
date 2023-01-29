###################################
 #         CORE VPC   #
###################################


locals {
  cluster_name = "prod-eu-west-2-cluster"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"
  name = var.core_vpc_name
  cidr = var.core_vpc_cidr

  azs             = var.core_vpc_azs
  private_subnets = var.core_vpc_private_subnets
  public_subnets  = var.core_vpc_public_subnets
  enable_nat_gateway = var.core_vpc_enable_nat_gateway
  

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

