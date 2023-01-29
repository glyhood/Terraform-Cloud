
####################################
#           CORE VPC VARIABLES  #
####################################


variable "core_vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "prod-eu-west-2-core-vpc"
}
variable "core_vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.18.0.0/16"
}
variable "core_vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["eu-west-2a", "eu-west-2b"]
}
variable "core_vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["172.18.0.0/19", "172.18.32.0/19"]
}
variable "core_vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["172.18.96.0/19", "172.18.128.0/19"]
}
variable "core_vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}

