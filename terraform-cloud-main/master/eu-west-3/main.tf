terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
  allowed_account_ids = ["902118332415"]
}

####################################
#           EU-WEST-3 RESOURCES    #
####################################

module "sso" {
  source  = "./sso/"
}