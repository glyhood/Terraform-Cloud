data "aws_route53_zone" "dev-flutterwave_com" {
  name         = "dev-flutterwave.com"
  private_zone = false
}