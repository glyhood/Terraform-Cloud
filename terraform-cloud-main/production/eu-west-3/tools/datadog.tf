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
    "${file("${path.module}/manifests/datadog.yaml")}"
  ]
}
