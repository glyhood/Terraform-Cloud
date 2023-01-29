terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "eu-west-2"
  allowed_account_ids = ["1234567890"]
  assume_role {
    role_arn     = "arn:aws:iam::1234567890:role/terraform-cloud"
  }
}

####################################
#           EU-WEST-2 RESOURCES    #
####################################

module "demo_vpc" {
  source  = "./vpc/"
}

module "demo_cluster" {
  source  = "./eks/"
}
module "acm" {
  source = "./acm/"
}