resource "aws_api_gateway_rest_api" "db_api" {
  name = "database_api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  body =<<EOF
{
  "openapi": "3.0.1",
  "info": {
    "title": "database_api",
    "version": "2019-09-10T14:24:50Z"
  },
  "paths": {
    "/user/{username}": {
      "get": {
        "parameters": [
          {
            "name": "username",
            "in": "path",
            "required": true,
            "schema": { "type": "string" }
          }
        ],
        "responses": {
          "200": {
            "description": "200 response",
            "content": {
              "application/json": {
                "schema": { "$ref": "#/components/schemas/Empty" }
              }
            }
          }
        },
        "x-amazon-apigateway-integration": {
          "uri": "${aws_lambda_function.database.invoke_arn}",
          "responses": {
            "default": { "statusCode": "200" }
          },
          "passthroughBehavior": "when_no_match",
          "httpMethod": "POST",
          "contentHandling": "CONVERT_TO_TEXT",
          "type": "aws_proxy"
        }
      }
    }
  }
} 
EOF
}

resource "aws_lambda_permission" "db_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.database.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.db_api.execution_arn}/*/*/*"
}
