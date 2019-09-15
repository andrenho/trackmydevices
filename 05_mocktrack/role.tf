resource "aws_iam_role_policy" "sqs_eb" {
  name = "SQSBeanstalkPolicy"
  role = "${aws_iam_role.sqs_eb.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage",
        "sqs:SendMessageBatch"
      ],
      "Resource": "arn:aws:sqs:*:*:*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "role1" {
  role       = "${aws_iam_role.sqs_eb.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_role_policy_attachment" "role2" {
  role       = "${aws_iam_role.sqs_eb.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}

resource "aws_iam_role" "sqs_eb" {
  name = "SQSBeanstalkRole"
  assume_role_policy = <<EOF
{
		"Version": "2012-10-17",
		"Statement": [
				{
						"Effect": "Allow",
						"Principal": {
								"Service": "elasticbeanstalk.amazonaws.com"
						},
						"Action": "sts:AssumeRole"
				}
		]
}
EOF
}

