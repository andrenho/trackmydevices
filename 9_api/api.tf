data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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
        "x-amazon-apigateway-integration": {
          "uri": "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${data.aws_lambda_function.database.function_name}:prod/invocations",
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

resource "aws_api_gateway_deployment" "prod" {
  depends_on  = ["aws_api_gateway_rest_api.db_api"]
  rest_api_id = "${aws_api_gateway_rest_api.db_api.id}"
  stage_name  = ""
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = "${aws_api_gateway_rest_api.db_api.id}"
  deployment_id = "${aws_api_gateway_deployment.prod.id}"
}

resource "aws_api_gateway_base_path_mapping" "test" {
  base_path   = "v1"
  api_id      = "${aws_api_gateway_rest_api.db_api.id}"
  stage_name  = "prod"
  domain_name = "${aws_api_gateway_domain_name.gamesmith.domain_name}"
}
