resource "helm_release" "argocd" {
  name            = "argocd"
  chart           = "argo-cd"
  repository      = "https://argoproj.github.io/argo-helm"
  version         = "5.17.4"
  namespace       = "argocd"
  reuse_values    = true
  cleanup_on_fail = true
  create_namespace = true
  values = [
    templatefile(
      "${path.module}/manifests/argocd.yaml",
      {
        jumpcloud_clientsecret = data.gitlab_project_variable.jumpcloud_clientsecret.value
        argocd_gat = data.gitlab_group_variable.argocd_gat.value
      }
    )
  ]
}

data "gitlab_group_variable" "argocd_gat" {
  group = "2813672"
  key   = "argocd_gat"
}

data "gitlab_project_variable" "jumpcloud_clientsecret" {
  project = "33471778"
  key   = "jumpcloud_clientsecret"
}