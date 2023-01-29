locals {
  kubeconfig = yamlencode({
    apiVersion      = "v1"
    kind            = "Config"
    current-context = "terraform"
    clusters = [{
      name = module.devops-eks.cluster_id
      cluster = {
        certificate-authority-data = module.devops-eks.cluster_certificate_authority_data
        server                     = module.devops-eks.cluster_endpoint
      }
    }]
    contexts = [{
      name = "terraform"
      context = {
        cluster = module.devops-eks.cluster_id
        user    = "terraform"
      }
    }]
    users = [{
      name = "terraform"
      user = {
        token = data.aws_eks_cluster_auth.devops-eks.token
      }
    }]
  })

  # we have to combine the configmap created by the eks module with the externally created node group/profile sub-modules
  aws_auth_configmap_yaml = <<-EOT
  ${chomp(module.devops-eks.aws_auth_configmap_yaml)}

      - rolearn: arn:aws:iam::724526322405:role/AWSReservedSSO_DevOps_ProdEnv_05222fed25e69974
        username: SSO_DevOps_ProdEnv
        groups:
          - system:masters
      - rolearn: arn:aws:iam::724526322405:role/terraform-cloud
        username: terraform-cloud
        groups:
          - system:masters
  EOT
}

resource "null_resource" "patch" {
  triggers = {
    kubeconfig = base64encode(local.kubeconfig)
    cmd_patch  = "kubectl patch configmap/aws-auth --patch \"${local.aws_auth_configmap_yaml}\" -n kube-system --kubeconfig <(echo $KUBECONFIG | base64 --decode)"
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = self.triggers.kubeconfig
    }
    command = <<EOT
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      chmod +x kubectl
      mkdir -p ~/.local/bin/kubectl
      mv ./kubectl ~/.local/bin/kubectl
      export PATH="~/.local/bin/kubectl:$PATH"
      source ~/.bashrc
      kubectl patch configmap/aws-auth --patch "${local.aws_auth_configmap_yaml}" -n kube-system --kubeconfig <(echo $KUBECONFIG | base64 --decode)
    EOT
  }
}