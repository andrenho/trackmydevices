data "aws_route53_zone" "main" {
  name = "tmd.gamesmith.co.uk."
}

data "aws_acm_certificate" "cert" {
  domain = "tmd.gamesmith.co.uk"
}

resource "aws_api_gateway_domain_name" "gamesmith" {
  domain_name              = "api.tmd.gamesmith.co.uk"
  regional_certificate_arn = "${data.aws_acm_certificate.cert.arn}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "api" {
  name    = "${aws_api_gateway_domain_name.gamesmith.domain_name}"
  type    = "A"
  zone_id = "${data.aws_route53_zone.main.id}"

  alias {
    evaluate_target_health = true
    name                   = "${aws_api_gateway_domain_name.gamesmith.regional_domain_name}"
    zone_id                = "${aws_api_gateway_domain_name.gamesmith.regional_zone_id}"
  }
}
