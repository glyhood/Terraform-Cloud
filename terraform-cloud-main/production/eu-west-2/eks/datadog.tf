provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    exec {
        api_version = "client.authentication.k8s.io/v1beta1"
        args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
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


# resource "datadog_dashboard" "example_dashboard" {}
# resource "datadog_integration_aws" "sandbox" {}
# resource "datadog_monitor" "process_alert_example" {}
