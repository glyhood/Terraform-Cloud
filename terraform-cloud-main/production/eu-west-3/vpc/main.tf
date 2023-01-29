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
 #         demo VPC   #
###################################


locals {
  demo_cluster_name = "prod-eu-west-3-demo-cluster"
}

module "demo_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"
  name = var.demo_vpc_name
  cidr = var.demo_vpc_cidr

  azs             = var.demo_vpc_azs
  private_subnets = var.demo_vpc_private_subnets
  public_subnets  = var.demo_vpc_public_subnets
  enable_nat_gateway = var.demo_vpc_enable_nat_gateway
  

  tags = {
    "kubernetes.io/cluster/${local.demo_cluster_name}" = "shared"
    Terraform   = "true"
    Environment = "prod"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.demo_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.demo_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}


