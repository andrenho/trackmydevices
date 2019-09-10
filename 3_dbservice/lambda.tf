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

resource "aws_lambda_permission" "db_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.database.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.db_api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "db_lambda_alias" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_alias.prod_alias.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.db_api.execution_arn}/*/*/*"
}
