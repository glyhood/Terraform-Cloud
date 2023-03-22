resource "gitlab_project" "this" {
  name                                             = var.name
  description                                      = var.description
  default_branch                                   = var.default_branch
  visibility_level                                 = var.visibility_level
  namespace_id                                     = var.parent_group
  initialize_with_readme                           = var.initialize_with_readme
  remove_source_branch_after_merge                 = var.remove_source_branch_after_merge
  allow_merge_on_skipped_pipeline                  = var.allow_merge_on_skipped_pipeline
  ci_forward_deployment_enabled                    = var.ci_forward_deployment_enabled
  only_allow_merge_if_pipeline_succeeds            = var.only_allow_merge_if_pipeline_succeeds
  only_allow_merge_if_all_discussions_are_resolved = var.only_allow_merge_if_all_discussions_are_resolved
  merge_requests_template                          = var.merge_requests_template
  merge_method                                     = var.merge_method
  issues_enabled                                   = var.issues_enabled
  request_access_enabled                           = var.request_access_enabled
  approvals_before_merge                           = var.approvals_before_merge

  ## Attempting fix/workaround for (documented) issue related to default branch protection
  # provisioner "local-exec" {
  #   command = <<EOT
  #      curl -X DELETE -H "PRIVATE-TOKEN: $GITLAB_TOKEN" ${var.gitlab_url}/projects/${gitlab_project.this.id}/protected_branches/${var.default_branch}
  #    EOT
  # }
}

## Attempting fix/workaround for (documented) issue related to default branch protection
# resource "null_resource" "delete_gitlab_auto_branch_protection" {
#   provisioner "local-exec" {
#     command = <<EOT
#         curl -X DELETE -H "PRIVATE-TOKEN: $GITLAB_TOKEN" ${var.gitlab_url}/projects/${gitlab_project.this.id}/protected_branches/${var.default_branch}
#       EOT
#   }
# }

resource "gitlab_branch_protection" "default" {
  count                        = var.default_branch_protection_enabled ? 1 : 0
  project                      = gitlab_project.this.id
  branch                       = var.default_branch
  push_access_level            = var.default_push_access_level
  merge_access_level           = var.default_merge_access_level
  unprotect_access_level       = var.default_unprotect_access_level
  allow_force_push             = var.default_allow_force_push
  code_owner_approval_required = var.default_code_owner_approval_required
  dynamic "allowed_to_merge" {
    for_each = var.default_groups_allowed_to_merge
    content {
      group_id = allowed_to_merge.value
    }
  }
  dynamic "allowed_to_merge" {
    for_each = var.default_users_allowed_to_merge
    content {
      user_id = allowed_to_merge.value
    }
  }

  dynamic "allowed_to_push" {
    for_each = var.default_groups_allowed_to_push
    content {
      group_id = allowed_to_push.value
    }
  }
  dynamic "allowed_to_push" {
    for_each = var.default_users_allowed_to_push
    content {
      user_id = allowed_to_push.value
    }
  }

  dynamic "allowed_to_unprotect" {
    for_each = var.default_groups_allowed_to_protect
    content {
      group_id = allowed_to_unprotect.value
    }
  }
  dynamic "allowed_to_unprotect" {
    for_each = var.default_users_allowed_to_unprotect
    content {
      user_id = allowed_to_unprotect.value
    }
  }
}

resource "gitlab_branch_protection" "this" {
  for_each                     = var.branch_protection
  project                      = gitlab_project.this.id
  branch                       = each.key
  push_access_level            = lookup(each.value, "push_access_level", var.default_push_access_level)
  merge_access_level           = lookup(each.value, "merge_access_level", var.default_merge_access_level)
  unprotect_access_level       = lookup(each.value, "unprotect_access_level", var.default_unprotect_access_level)
  allow_force_push             = lookup(each.value, "allow_force_push", var.default_allow_force_push)
  code_owner_approval_required = lookup(each.value, "code_owner_approval_required", var.default_code_owner_approval_required)
  dynamic "allowed_to_merge" {
    for_each = lookup(each.value, "groups_allowed_to_merge", var.default_groups_allowed_to_merge)
    content {
      group_id = allowed_to_merge.value
    }
  }
  dynamic "allowed_to_merge" {
    for_each = lookup(each.value, "users_allowed_to_merge", var.default_users_allowed_to_merge)
    content {
      user_id = allowed_to_merge.value
    }
  }

  dynamic "allowed_to_push" {
    for_each = lookup(each.value, "groups_allowed_to_push", var.default_groups_allowed_to_push)
    content {
      group_id = allowed_to_push.value
    }
  }
  dynamic "allowed_to_push" {
    for_each = lookup(each.value, "users_allowed_to_push", var.default_users_allowed_to_push)
    content {
      user_id = allowed_to_push.value
    }
  }

  dynamic "allowed_to_unprotect" {
    for_each = lookup(each.value, "groups_allowed_to_unprotect", var.default_groups_allowed_to_protect)
    content {
      group_id = allowed_to_unprotect.value
    }
  }
  dynamic "allowed_to_unprotect" {
    for_each = lookup(each.value, "users_allowed_to_unprotect", var.default_users_allowed_to_unprotect)
    content {
      user_id = allowed_to_unprotect.value
    }
  }
}

resource "gitlab_project_approval_rule" "default" {
  count                = var.default_branch_protection_enabled ? 1 : 0
  project              = gitlab_project.this.id
  name                 = var.default_project_approval_rule_name
  approvals_required   = var.default_approvals_required
  group_ids            = var.default_groups_allowed_to_approve
  user_ids             = var.default_users_allowed_to_approve
  protected_branch_ids = [gitlab_branch_protection.default[count.index].branch_protection_id]
  rule_type            = var.default_rule_type
  # disable_importing_default_any_approver_rule_on_create = var.default_disable_importing_default_any_approver_rule_on_create
}

resource "gitlab_project_approval_rule" "this" {
  for_each             = var.branch_protection
  project              = gitlab_project.this.id
  name                 = lookup(each.value, "project_approval_rule_name", var.default_project_approval_rule_name)
  approvals_required   = lookup(each.value, "approvals_required", var.default_approvals_required)
  group_ids            = lookup(each.value, "groups_allowed_to_approve", var.default_groups_allowed_to_approve)
  user_ids             = lookup(each.value, "users_allowed_to_approve", var.default_users_allowed_to_approve)
  protected_branch_ids = [gitlab_branch_protection.this[each.key].branch_protection_id]
  rule_type            = lookup(each.value, "rule_type", var.default_rule_type)
  # disable_importing_default_any_approver_rule_on_create = lookup(each.value, "disable_importing_default_any_approver_rule_on_create", var.default_disable_importing_default_any_approver_rule_on_create)
}
