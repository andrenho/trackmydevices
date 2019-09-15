resource "aws_elastic_beanstalk_application" "mocktrail" {
  name = "mocktrail"
}

resource "aws_elastic_beanstalk_environment" "mocktrail" {
  name                = "mocktrail"
  application         = "${aws_elastic_beanstalk_application.mocktrail.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.9.2 running Java 8"

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "${aws_iam_role.sqs_eb.id}"
  }
}
