locals {
  use_existing_route53_zone = true

  domain = "devops-flutterwave.com"
  acquire_domain = "aq2-flutterwave.com"
  domain_name = trimsuffix(local.domain, ".")
  acquire_domain_name = trimsuffix(local.acquire_domain, ".")

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
#          ACQUIRE ACM    #
####################################
data "aws_route53_zone" "acquire_zone" {
  count = local.use_existing_route53_zone ? 1 : 0
  name         = local.acquire_domain_name
  private_zone = false
}

resource "aws_route53_zone" "acquire_zone" {
  count = !local.use_existing_route53_zone ? 1 : 0
  name  = local.acquire_domain_name
}

module "acquire_acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.3.0"

  domain_name = local.acquire_domain_name
  zone_id     = coalescelist(data.aws_route53_zone.acquire_zone.*.zone_id, aws_route53_zone.acquire_zone.*.zone_id)[0]

  subject_alternative_names = [
    "*.${local.acquire_domain_name}",
    "*.coreflutterwaveprod.com"
  ]

  wait_for_validation = false

  tags = {
    Name = local.acquire_domain_name
  }
}