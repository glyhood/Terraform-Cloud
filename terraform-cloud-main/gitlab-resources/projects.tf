## Specify group names or group ID's manually or use the datasources
## If no group is specified, it defaults to the parent xyz group
## Description can be left blank

locals {
  gitlab_repos = {
    testrepo1                = { default_branch = "main", description = "example testrepo1", parent_group = 2240, argo = false, owner = "" }
  }
}

module "gitlab_project" {
  source                                           = "app.terraform.io/xyz/resources/gitlab//projects"
  for_each                                         = { for k, v in local.gitlab_repos : k => v if v.owner == "" }
  name                                             = lookup(local.gitlab_repos[each.key], "name", each.key)
  description                                      = lookup(local.gitlab_repos[each.key], "description", "")
  default_branch                                   = lookup(local.gitlab_repos[each.key], "default_branch", "")
  parent_group                                     = lookup(local.gitlab_repos[each.key], "parent_group", null)
  visibility_level                                 = lookup(local.gitlab_repos[each.key], "visibility_level", "private")
  initialize_with_readme                           = lookup(local.gitlab_repos[each.key], "initialize_with_readme", false)
  remove_source_branch_after_merge                 = lookup(local.gitlab_repos[each.key], "remove_source_branch_after_merge", true)
  allow_merge_on_skipped_pipeline                  = lookup(local.gitlab_repos[each.key], "allow_merge_on_skipped_pipeline", false)
  ci_forward_deployment_enabled                    = lookup(local.gitlab_repos[each.key], "ci_forward_deployment_enabled", true)
  only_allow_merge_if_pipeline_succeeds            = lookup(local.gitlab_repos[each.key], "only_allow_merge_if_pipeline_succeeds", false)
  only_allow_merge_if_all_discussions_are_resolved = lookup(local.gitlab_repos[each.key], "only_allow_merge_if_all_discussions_are_resolved", false)
  merge_requests_template                          = lookup(local.gitlab_repos[each.key], "merge_requests_template", null)
  request_access_enabled                           = lookup(local.gitlab_repos[each.key], "request_access_enabled", true)
  issues_enabled                                   = lookup(local.gitlab_repos[each.key], "issues_enabled", true)
  merge_method                                     = lookup(local.gitlab_repos[each.key], "merge_method", "merge")
  approvals_before_merge                           = lookup(local.gitlab_repos[each.key], "approvals_before_merge", 0)
  # branch_protection = {
  #   develop = {
  #     push_access_level                                     = "no one"
  #     merge_access_level                                    = "developer"
  #     unprotect_access_level                                = "maintainer"
  #     allow_force_push                                      = false
  #     code_owner_approval_required                          = false
  #     groups_allowed_to_merge                               = [0]
  #     groups_allowed_to_push                                = [0]
  #     groups_allowed_to_unprotect                           = [0]
  #     users_allowed_to_merge                                = [0]
  #     users_allowed_to_push                                 = [0]
  #     users_allowed_to_unprotect                            = [0]
  #     project_approval_rule_name                            = "develop branch rule"
  #     rule_type                                             = "regular"
  #     approvals_required                                    = 1
  #     groups_allowed_to_approve                             = [0]
  #     users_allowed_to_approve                              = [0]
  #     #disable_importing_default_any_approver_rule_on_create = false
  #   }
  # }
}

data "gitlab_project_variable" "gitlab_token" {
  project = "32557252"
  key   = "tf_cloud_gitlab_token"
}
