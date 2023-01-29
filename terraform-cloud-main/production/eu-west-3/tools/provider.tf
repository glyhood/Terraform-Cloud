data "aws_eks_cluster_auth" "devops-eks" {
  name = var.devops_cluster_name
}

data "aws_eks_cluster" "devops-eks" {
  name = var.devops_cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.devops-eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.devops-eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.devops-eks.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.devops_cluster_name]
      command     = "aws"
    }
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.devops-eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.devops-eks.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.devops_cluster_name]
    command     = "aws"
  }
}

# Providers not in the hashicorp namespace must be declared again in other modules via the required_providers configuration to specify the source

terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "15.7.1"
    }
  }
}
