/*
resource "aws_iam_role_policy" "db_lambda" {
  name = "DatabaseLambdaPolicy"
  role = "${aws_iam_role.db_lambda.id}"
  policy = <<EOF
EOF
}
*/

resource "aws_iam_rols" "db_lambda" {
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
