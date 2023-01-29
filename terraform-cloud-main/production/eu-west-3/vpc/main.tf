###################################
 #         DEVOPS VPC   #
###################################


locals {
  cluster_name = "prod-eu-west-3-devops-cluster"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"
  name = var.devops_vpc_name
  cidr = var.devops_vpc_cidr

  azs             = var.devops_vpc_azs
  private_subnets = var.devops_vpc_private_subnets
  public_subnets  = var.devops_vpc_public_subnets
  enable_nat_gateway = var.devops_vpc_enable_nat_gateway
  

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

###################################
 #         ACQUIRE VPC   #
###################################


locals {
  acquire_cluster_name = "prod-eu-west-3-acquire-cluster"
}

module "acquire_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"
  name = var.acquire_vpc_name
  cidr = var.acquire_vpc_cidr

  azs             = var.acquire_vpc_azs
  private_subnets = var.acquire_vpc_private_subnets
  public_subnets  = var.acquire_vpc_public_subnets
  enable_nat_gateway = var.acquire_vpc_enable_nat_gateway
  

  tags = {
    "kubernetes.io/cluster/${local.acquire_cluster_name}" = "shared"
    Terraform   = "true"
    Environment = "prod"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.acquire_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.acquire_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}


