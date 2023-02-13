resource "gitlab_group_access_token" "xyz" {
  group        = "2813672"
  name         = "ArgoCD's access token"
  access_level = "developer"

  scopes = ["api"]
}

resource "gitlab_group_variable" "argocd_gat" {
  group = "2813672"
  key   = "argocd_gat"
  value = gitlab_group_access_token.xyz.token
}
