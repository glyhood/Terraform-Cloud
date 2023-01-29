terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  allowed_account_ids = ["724526322405"]
  assume_role {
    role_arn     = "arn:aws:iam::724526322405:role/terraform-cloud"
  }
}

####################################
#           EU-WEST-1 RESOURCES    #
####################################


module "f4b_vpc" {
  source  = "./vpc/"
}

module "f4b_eks" {
  source  = "./eks/"
}

module "f4b_acm" {
  source = "./acm/"
}