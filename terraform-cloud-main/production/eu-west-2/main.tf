terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
  allowed_account_ids = ["724526322405"]
  assume_role {
    role_arn     = "arn:aws:iam::724526322405:role/terraform-cloud"
  }
}

####################################
#           EU-WEST-2 RESOURCES    #
####################################

module "core_vpc" {
  source  = "./vpc/"
}

module "core_cluster" {
  source  = "./eks/"
}
module "acm" {
  source = "./acm/"
}