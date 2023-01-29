
####################################
#           DEVOPS VPC VARIABLES  #
####################################


variable "devops_vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "prod-eu-west-3-devops-vpc"
}
variable "devops_vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.17.0.0/16"
}
variable "devops_vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["eu-west-3a", "eu-west-3b"]
}
variable "devops_vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["172.17.0.0/19", "172.17.32.0/19"]
}
variable "devops_vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["172.17.96.0/19", "172.17.128.0/19"]
}
variable "devops_vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}



####################################
#           demo VPC VARIABLES  #
####################################


variable "demo_vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "prod-eu-west-3-demo-vpc"
}
variable "demo_vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.19.0.0/16"
}
variable "demo_vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["eu-west-3a", "eu-west-3b"]
}
variable "demo_vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["172.19.0.0/19", "172.19.32.0/19"]
}
variable "demo_vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["172.19.96.0/19", "172.19.128.0/19"]
}
variable "demo_vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}
