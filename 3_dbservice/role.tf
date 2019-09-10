resource "aws_iam_role_policy" "db_lambda" {
  name = "DatabaseLambdaPolicy"
  role = "${aws_iam_role.db_lambda.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:us-east-1:308301740443:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:us-east-1:308301740443:log-group:/aws/lambda/database:*"
        },
				{
						"Effect": "Allow",
						"Action": [
								"xray:PutTraceSegments",
								"xray:PutTelemetryRecords"
						],
						"Resource": "*"
				}
    ]
}
EOF
}

/*
resource "aws_iam_role_policy_attachment" "execution_role" {
  role       = "${aws_iam_role.db_lambda.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
*/

resource "aws_iam_role" "db_lambda" {
  name = "DatabaseLambdaRole"
  assume_role_policy = <<EOF
{
		"Version": "2012-10-17",
		"Statement": [
				{
						"Effect": "Allow",
						"Principal": {
								"Service": "lambda.amazonaws.com"
						},
						"Action": "sts:AssumeRole"
				}
		]
}
EOF
}
