variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "parent_group" {
  type = number
}

variable "default_branch" {
  type = string
}

variable "visibility_level" {
  type    = string
  default = "private"
}

variable "initialize_with_readme" {
  type    = bool
  default = false
}

variable "remove_source_branch_after_merge" {
  type    = bool
  default = true
}

variable "allow_merge_on_skipped_pipeline" {
  type    = bool
  default = false
}

variable "ci_forward_deployment_enabled" {
  type    = bool
  default = true
}

variable "only_allow_merge_if_pipeline_succeeds" {
  type    = bool
  default = false
}

variable "only_allow_merge_if_all_discussions_are_resolved" {
  type    = bool
  default = false
}

variable "merge_requests_template" {
  type    = string
  default = null
}

variable "merge_method" {
  type    = string
  default = null
}

variable "issues_enabled" {
  type    = bool
  default = true
}

variable "request_access_enabled" {
  type    = bool
  default = true
}

variable "approvals_before_merge" {
  type    = number
  default = 0
}

variable "gitlab_url" {
  default = ""
}

variable "branch_protection" {
  type = map(object({
    push_access_level            = string
    merge_access_level           = string
    unprotect_access_level       = string
    allow_force_push             = bool
    code_owner_approval_required = bool
    groups_allowed_to_merge      = list(number)
    users_allowed_to_merge       = list(number)
    groups_allowed_to_push       = list(number)
    users_allowed_to_push        = list(number)
    groups_allowed_to_unprotect  = list(number)
    users_allowed_to_unprotect   = list(number)
    project_approval_rule_name   = string
    approvals_required           = number
    groups_allowed_to_approve    = list(number)
    users_allowed_to_approve     = list(number)
    rule_type                    = string
    # disable_importing_default_any_approver_rule_on_create = bool
  }))
  default = {}
}

variable "default_push_access_level" {
  type    = string
  default = "maintainer"
}

variable "default_merge_access_level" {
  type    = string
  default = "maintainer"
}

variable "default_unprotect_access_level" {
  type    = string
  default = "maintainer"
}

variable "default_allow_force_push" {
  type    = bool
  default = false
}

variable "default_code_owner_approval_required" {
  type    = bool
  default = false
}

variable "default_groups_allowed_to_merge" {
  type    = list(any)
  default = []
}

variable "default_users_allowed_to_merge" {
  type    = list(any)
  default = []
}

variable "default_groups_allowed_to_push" {
  type    = list(any)
  default = []
}

variable "default_users_allowed_to_push" {
  type    = list(any)
  default = []
}

variable "default_groups_allowed_to_protect" {
  type    = list(any)
  default = []
}

variable "default_users_allowed_to_unprotect" {
  type    = list(any)
  default = []
}

variable "default_branch_protection_enabled" {
  type    = bool
  default = false
}

variable "default_project_approval_rule_name" {
  type    = string
  default = "approval rule"
}

variable "default_rule_type" {
  type    = string
  default = "regular"
}

variable "default_approvals_required" {
  type    = number
  default = 1
}

variable "default_groups_allowed_to_approve" {
  type    = list(number)
  default = []
}

variable "default_users_allowed_to_approve" {
  type    = list(number)
  default = []
}

# variable "default_disable_importing_default_any_approver_rule_on_create" {
#   type    = bool
#   default = true
# }
