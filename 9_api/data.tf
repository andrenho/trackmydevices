data "aws_lambda_function" "database" {
  function_name = "database_api"
}

data "aws_dynamodb_table" "track" {
  name = "track"
}
