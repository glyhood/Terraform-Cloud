terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region              = "eu-west-3"
  allowed_account_ids = ["326355388919"]
  assume_role {
    role_arn = "arn:aws:iam::326355388919:role/terraform-cloud"
  }
}

####################################
#           EU-WEST-3 RESOURCES    #
####################################

module "dev_ew3_vpc" {
  source = "./vpc/"
}

module "dev_ew3_route53" {
  source = "./route53/"
}

module "dev_ew3_acm" {
  source = "./acm/"
}

module "dev_ew3_eks" {
  source = "./eks/"
}

module "dev_ew3_db" {
  source = "./rds/"
}
