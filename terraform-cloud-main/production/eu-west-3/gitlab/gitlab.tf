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

locals {
  gitlab_repos = {
    testrepo1 = { description = "example testrepo1" }
    testrepo2 = { description = "example testrepo2" }
    # testrepo3 = { project_id = 6166, description = "" }
  }
}

module "gitlab_project" {
  source = "../gitlab_module"
  for_each    = local.gitlab_repos
  name        = "${each.key}"
  description = local.gitlab_repos[each.key].description
}
