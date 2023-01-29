###################################
 #         ACQUIRE CLUSTER  #
###################################

module "acquire-eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.3.1"

  cluster_name                    = var.acquire_cluster_name
  cluster_version                 = "1.23"
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true
  iam_role_use_name_prefix        = false
  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = "vpc-016303f141f8cd787"
  subnet_ids = ["subnet-0c6d22a0248d74407", "subnet-0cc46aefe2e852ed5"]

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 200
    instance_types = ["r6i.4xlarge"]
    update_launch_template_default_version = false
    launch_template_version= 11
  }

  eks_managed_node_groups = {
    main_pool = {
      min_size     = 1
      max_size     = 40
      desired_size = 1
      capacity_type = "ON_DEMAND"
      labels = {
        "environment" = var.environment
        "managed_by"  = "terraform"
      }
      tags = {
        "Environment"                                   = "Acquire Prod"
        "Terraform"                                     = "true"
        "Owner"                                         = "Acquire Prod"
        "k8s.io/cluster-autoscaler/${var.acquire_cluster_name}" = "owned"
        "k8s.io/cluster-autoscaler/enabled "            = "true"
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