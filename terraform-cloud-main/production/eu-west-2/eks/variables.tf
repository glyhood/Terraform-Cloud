variable "environment" {
  type    = string
  default = "prod"
}

variable "cluster_name" {
  type    = string
  default = "prod-eu-west-2-demo-cluster"
}

variable "auto_scaling_enabled" {
  type    = bool
  default = true
}

