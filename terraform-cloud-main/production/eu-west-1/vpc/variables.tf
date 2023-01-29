# # VPC VARIABLES
variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "prod-eu-west-1-f4b-vpc"
}
variable "region" {
  description = "Name of region"
  type        = string
  default     = "eu-west-1"
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.16.0.0/16"
}
variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}
variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["172.16.0.0/19", "172.16.32.0/19", "172.16.64.0/19"]
}
variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["172.16.96.0/19", "172.16.128.0/19", "172.16.160.0/19"]
}
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}
