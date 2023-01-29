module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.22"
  vpc_id          = "vpc-015b83c4bd778c70e"
  subnets         = ["subnet-0bab7de88454085ce", "subnet-0caabae7c9409557d"]

  manage_aws_auth = true

  attach_worker_cni_policy = true

  write_kubeconfig = false

  tags = {
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"             = true
  }

  map_roles = [
    { "groups" : ["system:masters"], "rolearn" : "arn:aws:iam::724526322405:role/AWSReservedSSO_DevOps_ProdEnv_05222fed25e69974", "username" : "SSO_DevOps_ProdEnv" },
    # No need to map the terraform-cloud role anymore for new clusters going forward. It is added automatically as the terraform-cloud assume_roles are now used
    { "groups" : ["system:masters"], "rolearn" : "arn:aws:iam::724526322405:role/terraform-cloud", "username" : "terraform_cloud" }
  ]

  # Managed Node Groups
  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    node_group_1 = {
      desired_capacity = 2
      max_capacity     = 10
      min_capacity     = 2
      name_prefix      = "ew2-core-cluster2-node_grp_1"
      instance_types   = ["r6i.4xlarge"]
      capacity_type    = "ON_DEMAND"
      additional_tags = {
        "Environment"                                   = "prod"
        "Terraform"                                     = "true"
        "Owner"                                         = "DevOps"
        "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
        "k8s.io/cluster-autoscaler/enabled "            = "true"
      }
    }
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = var.cluster_name
  addon_name   = "kube-proxy"
  resolve_conflicts = "OVERWRITE"
}
resource "aws_eks_addon" "vpc-cni" {
  cluster_name = var.cluster_name
  addon_name   = "vpc-cni"
  resolve_conflicts = "OVERWRITE"
}
resource "aws_eks_addon" "coredns" {
  cluster_name = var.cluster_name
  addon_name   = "coredns"
  resolve_conflicts = "OVERWRITE"
}