resource "aws_lambda_permission" "db_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = "${data.aws_lambda_function.database.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.db_api.execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "db_lambda_alias" {
  action        = "lambda:InvokeFunction"
  function_name = "${data.aws_lambda_function.database.function_name}"
  qualifier     = "prod"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.db_api.execution_arn}/*/*/*"
}
