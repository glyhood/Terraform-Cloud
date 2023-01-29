data "aws_eks_cluster_auth" "devops-eks" {
  name = module.devops-eks.cluster_id
}

data "aws_eks_cluster" "devops-eks" {
  name = module.devops-eks.cluster_id
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.devops-eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.devops-eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.devops-eks.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
      command     = "aws"
    }
  }
}