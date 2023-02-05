resource "gitlab_group" "this" {
  name        = var.name
  path        = var.path
  description = var.description
}