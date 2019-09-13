resource "aws_iam_role" "table_track" {
  name = "TrackTableReadRole"
  assume_role_policy = <<EOF
{
		"Version": "2012-10-17",
		"Statement": [
				{
						"Effect": "Allow",
						"Principal": {
								"Service": "apigateway.amazonaws.com"
						},
						"Action": "sts:AssumeRole"
				}
		]
}
EOF
}

resource "aws_iam_role_policy" "table_track" {
  name = "TrackTableReadPolicy"
  role = "${aws_iam_role.table_track.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "dynamodb:Query",
            "Resource": "${aws_dynamodb_table.track.arn}"
        }
    ]
}
EOF
}
