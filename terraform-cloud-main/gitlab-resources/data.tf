## Resources created manually (external to terraform) such as "gitlab groups" can be accessed and used via the data sources

data "gitlab_group" "devops" {
  full_path = "xyzgo/devops"
}

data "gitlab_group" "send" {
  full_path = "xyzgo/send"
}