# Providers not in the hashicorp namespace must be declared again in other modules via the required_providers configuration to specify the source

terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "15.8.0"
    }
  }
}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = var.gitlab_url
}