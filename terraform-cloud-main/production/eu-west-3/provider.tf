# Providers not in the hashicorp namespace must be declared again in other modules via the required_providers configuration to specify the source

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "15.7.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
  allowed_account_ids = ["xxxx"]
  assume_role {
    role_arn     = "arn:aws:iam::xxxx:role/terraform-cloud"
  }
}

provider "gitlab" {
  token = var.gitlab_token
  base_url = var.gitlab_url
}