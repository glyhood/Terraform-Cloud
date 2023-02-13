## Specify group names or group ID's manually or use the datasources
## If no group is specified, it defaults to the parent xyz group
## Description can be left blank

locals {
  gitlab_repos = {
    demorepo = { name = "demorepo", description = "example testrepo1", group = data.gitlab_group.devops.id }
  }
}

module "gitlab_project" {
  source      = "app.terraform.io/xyz/resources/gitlab//projects"
  version     = "0.4.3"
  for_each    = local.gitlab_repos
  name        = local.gitlab_repos[each.key].name
  description = local.gitlab_repos[each.key].description
  namespace   = local.gitlab_repos[each.key].group
  init_pipeline = "https://user:${data.gitlab_project_variable.gitlab_token.value}@gitlab.com/xyzgo/devops/new-project-template.git"
}

data "gitlab_project_variable" "gitlab_token" {
  project = "32557252"
  key   = "tf_cloud_gitlab_token"
}