provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

resource "helm_release" "datadog_agent" {
  name            = "datadog"
  chart           = "datadog"
  repository      = "https://helm.datadoghq.com"
  version         = "2.33.8"
  namespace       = "datadog"
  reuse_values    = true
  recreate_pods   = true
  force_update    = true
  cleanup_on_fail = true
  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
