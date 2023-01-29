provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.acquire-eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.acquire-eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.acquire-eks.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.acquire_cluster_name]
      command     = "aws"
    }
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
