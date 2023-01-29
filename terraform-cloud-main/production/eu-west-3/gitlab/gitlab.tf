resource "gitlab_group_access_token" "xxxx" {
  group        = "xxxx"
  name         = "ArgoCD's access token"
  access_level = "developer"

  scopes = ["api"]
}

resource "gitlab_group_variable" "argocd_gat" {
  group = "xxxx"
  key   = "argocd_gat"
  value = gitlab_group_access_token.xxxx.token
}
