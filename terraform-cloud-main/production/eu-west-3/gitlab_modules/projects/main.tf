resource "gitlab_project" "this" {
  name                   = var.name
  description            = var.description
  default_branch         = "master"
  visibility_level       = "private"
  namespace_id           = var.namespace
}

resource "gitlab_branch_protection" "this" {
  project                = gitlab_project.this.id
  branch                 = "master"
  push_access_level      = "no one"
  merge_access_level     = "developer"
  unprotect_access_level = "maintainer"
  allowed_to_merge {
    group_id = 1428
  }
}

resource "gitlab_project_approval_rule" "this" {
  project              = gitlab_project.this.id
  name                 = "MR Approval Rule"
  approvals_required   = 2
  group_ids            = [1428]
  protected_branch_ids = [gitlab_branch_protection.this.branch_protection_id]
}