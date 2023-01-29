
####################################
#           demo VPC VARIABLES  #
####################################


variable "demo_vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "prod-eu-west-2-vpc"
}
variable "demo_vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.18.0.0/16"
}
variable "demo_vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["eu-west-2a", "eu-west-2b"]
}
variable "demo_vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["172.18.0.0/19", "172.18.32.0/19"]
}
variable "demo_vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["172.18.96.0/19", "172.18.128.0/19"]
}
variable "demo_vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}

