module "dev-ew3-infra-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"
  name = "dev-ew3-infra-vpc"
  cidr = "172.17.0.0/16"

  azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  private_subnets = ["172.17.0.0/20", "172.17.16.0/20", "172.17.32.0/20"]
  public_subnets  = ["172.17.48.0/20", "172.17.64.0/20", "172.17.80.0/20"]
  enable_nat_gateway = true
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}