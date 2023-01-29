####################################
#           EU-WEST-3 RESOURCES    #
####################################

module "devops_vpc" {
  source  = "./vpc/"
}

module "devops_cluster" {
  source  = "./eks/"
}

module "demo_cluster" {
  source  = "./demo-eks/"
}

module "route53" {
  source  = "./route53/"
}

module "acm" {
  source = "./acm/"
}

module "tools" {
  source = "./tools/"
}

module "gitlab" {
  source = "./gitlab/"
}