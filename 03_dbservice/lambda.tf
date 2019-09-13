resource "aws_lambda_function" "database" {
  function_name = "database_api"
  filename      = "empty.zip"
  role          = "${aws_iam_role.db_lambda.arn}"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.7"
  publish       = true
  tracing_config {
    mode        = "Active"
  }
}

resource "aws_lambda_alias" "prod_alias" {
  name             = "prod"
  function_name    = "${aws_lambda_function.database.arn}"
  function_version = "${aws_lambda_function.database.version}"
}
