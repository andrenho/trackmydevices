resource "aws_lambda_function" "database" {
  function_name = "database_api"
  filename      = "empty.zip"
  role          = "${aws_iam_role.db_lambda.arn}"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.7"
  tracing_config {
    mode        = "Active"
  }
}
