locals {
  name   = "dev-eks-cluster"
}

module "dev-eks-cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.31.2"

  cluster_name                    = local.name
  cluster_version                 = "1.23"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
      addon_version = "v1.8.7-eksbuild.3"
    }
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
      addon_version = "v1.22.11-eksbuild.2"
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
      addon_version = "v1.12.0-eksbuild.1"
    }
    aws-ebs-csi-driver = {
      resolve_conflicts = "OVERWRITE"
      addon_version = "v1.13.0-eksbuild.2"
    }
  }

  vpc_id     = "vpc-008ed9a17829e8ffd"
  subnet_ids = ["subnet-0a04228d42a47598b", "subnet-0b855b98c947484cf", "subnet-0dc04908fcaf3f135"]
  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::326355388919:role/AWSReservedSSO_DevOps_DevEnv_78b26488f6bc173b"
      username = "SSO_DevOps_DevEnv"
      groups   = ["system:masters"]
    }
  ]

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 100
    instance_types = ["r6i.4xlarge"]
    update_launch_template_default_version = false
  }

  eks_managed_node_groups = {
    node-group-1 = {
      min_size       = 1
      max_size       = 10
      desired_size   = 2
      instance_types = ["r6i.4xlarge"]
      capacity_type  = "ON_DEMAND"
      labels = {
        Environment = "development"
      }
      tags = {
        Environment                               = "development"
        Terraform                                 = "true"
        Owner                                     = "DevOps"
        "k8s.io/cluster-autoscaler/dev-eks-cluster" = "owned"
        "k8s.io/cluster-autoscaler/enabled"       = "true"
      }
    }
    
    node-group-2 = {
      min_size       = 1
      max_size       = 20
      desired_size   = 4
      instance_types = ["m5.xlarge", "r6i.4xlarge"]
      capacity_type  = "SPOT"
      labels = {
        Environment = "development"
      }
      tags = {
        Environment                                                      = "development"
        Terraform                                                        = "true"
        Owner                                                            = "DevOps"
        "k8s.io/cluster-autoscaler/dev-eks-cluster" = "owned"
        "k8s.io/cluster-autoscaler/enabled"                              = "true"
      }
    }
  }

  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    ingress_cluster_control_plane = {
      description                   = "From Control plane security group"
      protocol                      = "tcp"
      from_port                     = 1025
      to_port                       = 65535
      type                          = "ingress"
      source_cluster_security_group = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}

