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
    testrepo1 = { description = "example testrepo1", group = module.gitlab_group["testgroup1"].id }
    testrepo2 = { description = "example testrepo2", group = module.gitlab_group["testgroup2"].id }
    # testrepo3 = { project_id = 6166, description = "" }
  }
  gitlab_groups = {
    testgroup1 = { description = "example testgroup1", path = "group/devops"}
    testgroup2 = { description = "example testgroup2", path = "group/devops"}
  }
}

module "gitlab_project" {
  source = "../gitlab_modules/projects"
  for_each    = local.gitlab_repos
  name        = "${each.key}"
  description = local.gitlab_repos[each.key].description
  namespace = local.gitlab_repos[each.key].group
}

module "gitlab_group" {
  source = "../gitlab_modules/groups"
  for_each    = local.gitlab_groups
  name        = "${each.key}"
  description = local.gitlab_groups[each.key].description
  path = local.gitlab_groups[each.key].path
}
