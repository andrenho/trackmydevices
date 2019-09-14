data "aws_route53_zone" "main" {
  name = "tmd.gamesmith.co.uk."
}

resource "aws_route53_record" "rds" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "mocktrail.tmd.gamesmith.co.uk."
  type    = "CNAME"
  ttl     = 300
  records = ["${aws_elastic_beanstalk_environment.mocktrail.cname}"]
}
