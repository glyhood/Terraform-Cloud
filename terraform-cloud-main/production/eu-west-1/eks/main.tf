locals {
  cluster_name = "prod-eu-west-1-cluster"
}
data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.20.0"
  cluster_version = "1.22"
  cluster_name    = local.cluster_name
  vpc_id          = "vpc-xxxx"
  subnets         = ["subnet-xxxx", "subnet-xxxx", "subnet-xxxx"]
  map_roles = [
    { "groups" : ["system:masters"], "rolearn" : "arn:aws:iam::xxxx:role/AWSReservedSSO_xxxx", "username" : "SSO_DevOps_ProdEnv" },
    ## No need to map the terraform-cloud role anymore for new clusters going forward. It is added automatically as the terraform-cloud assume_roles are now used
  { "groups" : ["system:masters"], "rolearn" : "arn:aws:iam::xxxx:role/terraform-cloud", "username" : "terraform_cloud" }]
  manage_aws_auth = true

  node_groups = {
    node-group-1 = {
      name                   = "f4b-node-grp-1"
      desired_capacity       = 4
      max_capacity           = 50
      min_capacity           = 1
      instance_types         = ["r6i.4xlarge"]
      capacity_type          = "ON_DEMAND"
      ami_id                 = "ami-xxxx"
      create_launch_template = true
      additional_tags = {
        "Environment"                                     = "Prod"
        "Terraform"                                       = "true"
        "Owner"                                           = "DevOps"
        "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
        "k8s.io/cluster-autoscaler/enabled "              = "true"
      }
    }
  }

}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name      = local.cluster_name
  addon_name        = "kube-proxy"
  resolve_conflicts = "OVERWRITE"
}
resource "aws_eks_addon" "vpc-cni" {
  cluster_name      = local.cluster_name
  addon_name        = "vpc-cni"
  resolve_conflicts = "OVERWRITE"
}
resource "aws_eks_addon" "coredns" {
  cluster_name      = local.cluster_name
  addon_name        = "coredns"
  resolve_conflicts = "OVERWRITE"
}
