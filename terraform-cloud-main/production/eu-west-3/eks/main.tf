module "devops-eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.3.1"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.22"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = "vpc-0e649863a64c19894"
  subnet_ids = ["subnet-046d999475ec4688c", "subnet-06f1edc96e2a806fe"]

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 50
    instance_types = ["m5.xlarge"]
    update_launch_template_default_version = false
    launch_template_version = 29
  }

  eks_managed_node_groups = {
    main_pool = {
      min_size     = 2
      max_size     = 6
      desired_size = 4

      capacity_type = "ON_DEMAND"
      labels = {
        "environment" = var.environment
        "managed_by"  = "terraform"
      }
      tags = {
        "Environment"                                   = "DevOps"
        "Terraform"                                     = "true"
        "Owner"                                         = "DevOps"
        "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
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