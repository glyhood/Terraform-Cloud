locals {
  use_existing_route53_zone = true

  domain = "demo.com"
  demo_domain = "demo.com"
  domain_name = trimsuffix(local.domain, ".")
  demo_domain_name = trimsuffix(local.demo_domain, ".")

}

data "aws_route53_zone" "this" {
  count = local.use_existing_route53_zone ? 1 : 0

  name         = local.domain_name
  private_zone = false
}

resource "aws_route53_zone" "this" {
  count = !local.use_existing_route53_zone ? 1 : 0
  name  = local.domain_name
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.3.0"

  domain_name = local.domain_name
  zone_id     = coalescelist(data.aws_route53_zone.this.*.zone_id, aws_route53_zone.this.*.zone_id)[0]

  subject_alternative_names = [
    "*.${local.domain_name}",
  ]

  wait_for_validation = false

  tags = {
    Name = local.domain_name
  }
}
####################################
#          demo ACM    #
####################################
data "aws_route53_zone" "demo_zone" {
  count = local.use_existing_route53_zone ? 1 : 0
  name         = local.demo_domain_name
  private_zone = false
}

resource "aws_route53_zone" "demo_zone" {
  count = !local.use_existing_route53_zone ? 1 : 0
  name  = local.demo_domain_name
}

module "demo_acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.3.0"

  domain_name = local.demo_domain_name
  zone_id     = coalescelist(data.aws_route53_zone.demo_zone.*.zone_id, aws_route53_zone.demo_zone.*.zone_id)[0]

  subject_alternative_names = [
    "*.${local.demo_domain_name}",
    "*.coreflutterwaveprod.com"
  ]

  wait_for_validation = false

  tags = {
    Name = local.demo_domain_name
  }
}