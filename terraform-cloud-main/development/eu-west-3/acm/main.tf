data "aws_acm_certificate" "dev-flutterwave-com" {
  domain      = "*.dev-flutterwave.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}